module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def create
      Rails.logger.debug "[SessionsController] Entering #create"

      # Let Devise handle everything first
      begin
        super
      rescue Devise::Lockable::LockedError => e
        Rails.logger.debug "[SessionsController] Caught Devise::Lockable::LockedError"
        return render json: { error: I18n.t("devise.failure.locked"), reason: "locked" }, status: :unauthorized
      end
    end

    protected

    # Called when authentication fails
    def render_create_error_bad_credentials
      Rails.logger.debug "[SessionsController] Entering render_create_error_bad_credentials"
      Rails.logger.debug "[SessionsController] request.env keys: #{request.env.keys.inspect}"
      warden = request.env['warden'] || {}
      Rails.logger.debug "[SessionsController] warden: #{warden.inspect}"
      opts = request.env['warden.options'] || {}
      Rails.logger.debug "[SessionsController] warden.options: #{opts.inspect}"

      if opts[:message] == :last_attempt
        Rails.logger.debug "[SessionsController] Last attempt before lock"
        return render json: { error: I18n.t("devise.failure.last_attempt"), reason: "last_attempt" }, status: :unauthorized
      end
      attempted_user = resource_class.find_by(email: resource_params[:email])
      if attempted_user
        Rails.logger.debug "[SessionsController] locked_at: #{attempted_user.locked_at}"
        Rails.logger.debug "[SessionsController] failed_attempts: #{attempted_user.failed_attempts}"
      end
      if attempted_user && !attempted_user.active_for_authentication?
        reason = attempted_user.inactive_message
        Rails.logger.debug "[SessionsController] inactive_message: #{reason}"
        return render json: { error: I18n.t("devise.failure.#{reason}"), reason: reason }, status: :unauthorized
      end

      # Fallback
      super
    end

    private

    def resource_params
      params.permit(:email, :password)
    end
  end
end
