module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def create
      user = User.find_by(email: resource_params[:email])

      if user&.is_archived
        return render json: { error: I18n.t("devise.failure.archived") }, status: :unauthorized
      end

      if user&.access_locked?
        return render json: { error: I18n.t("devise.failure.locked") }, status: :unauthorized
      end

      if user&.password_expired?
        return render json: {
          error: I18n.t("devise.failure.password_expired"),
          reason: "password_expired"
        }, status: :unauthorized
      end

      super

    end

    protected

    # Called when authentication fails
    def render_create_error_bad_credentials
      attempted_user = resource_class.find_by(email: resource_params[:email])

      if attempted_user
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
        return render json: { error: I18n.t("devise.failure.#{reason}"), reason: reason }, status: :unauthorized
      end

      super
    end

    private

    def resource_params
      params.permit(:email, :password)
    end
  end
end
