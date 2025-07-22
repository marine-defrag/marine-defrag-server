module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def create
      @resource = warden.authenticate(scope: resource_name, recall: nil, throw: false)

      if @resource
        sign_in(resource_name, @resource)
        return render_create_success
      end

      attempted_email = resource_params[:email]
      attempted_user = resource_class.find_by(email: attempted_email)

      if attempted_user && !attempted_user.active_for_authentication?
        reason = attempted_user.inactive_message
        Rails.logger.debug "[SessionsController] inactive_message: #{reason.inspect}"
        Rails.logger.debug "[SessionsController] locked_at: #{attempted_user.locked_at.inspect}"
        Rails.logger.debug "[SessionsController] failed_attempts: #{attempted_user.failed_attempts}"

        case reason
        when :locked
          return render json: { error: I18n.t("devise.failure.locked"), reason: "locked" }, status: :unauthorized
        when :inactive
          return render json: { error: I18n.t("devise.failure.inactive"), reason: "inactive" }, status: :unauthorized
        else
          return render json: { error: I18n.t("devise.failure.unauthenticated"), reason: reason }, status: :unauthorized
        end
      end

      render json: { error: I18n.t("devise.failure.invalid") }, status: :unauthorized
    end

    private

    def resource_params
      params.permit(:email, :password)
    end
  end
end
