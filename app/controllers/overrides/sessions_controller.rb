module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    protected

    # Called when authentication fails
    def render_create_error_bad_credentials
      Rails.logger.debug "[SessionsController] Entering render_create_error_bad_credentials"
      attempted_user = resource_class.find_by(email: resource_params[:email])
      if attempted_user
        Rails.logger.debug "[SessionsController] locked_at: #{attempted_user.locked_at}"
        Rails.logger.debug "[SessionsController] failed_attempts: #{attempted_user.failed_attempts}"

        max_attempts = Devise.maximum_attempts || 3
        if attempted_user.failed_attempts == (max_attempts - 1)
          Rails.logger.debug "[SessionsController] Detected last attempt before lock"
          return render json: {
            error: I18n.t("devise.failure.last_attempt"),
            reason: "last_attempt"
          }, status: :unauthorized
        end
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
