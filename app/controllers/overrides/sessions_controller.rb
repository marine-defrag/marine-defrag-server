module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def create
      @resource = warden.authenticate(auth_options)

      if @resource
        sign_in(:user, @resource)  # Ensure Devise sign-in
        return render_create_success
      end

      # If authentication failed, get the attempted resource (for error analysis)
      attempted_email = resource_params[:email]
      attempted_resource = User.find_by(email: attempted_email)

      if attempted_resource
        Rails.logger.debug "[SessionsController] inactive_message: #{attempted_resource.inactive_message.inspect}"
        Rails.logger.debug "[SessionsController] locked_at: #{attempted_resource.locked_at.inspect}"
        Rails.logger.debug "[SessionsController] failed_attempts: #{attempted_resource.failed_attempts}"
        Rails.logger.debug "[SessionsController] Warden options: #{request.env['warden.options'].inspect}"

        case attempted_resource.inactive_message
        when :locked
          return render json: { error: I18n.t("devise.failure.locked"), reason: :locked }, status: :unauthorized
        when :archived
          return render json: { error: I18n.t("devise.failure.archived"), reason: :archived }, status: :unauthorized
        end
      end

      if request.env["warden.options"]&.[](:message) == :last_attempt
        return render json: { error: I18n.t("devise.failure.last_attempt"), reason: "last-attempt" }, status: :unauthorized
      end

      render json: { error: I18n.t("devise.failure.invalid") }, status: :unauthorized
    end
  end
end
