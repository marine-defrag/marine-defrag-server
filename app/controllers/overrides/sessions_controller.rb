module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def create
      begin
        @resource = warden.authenticate!(auth_options) # Will raise on failure
        sign_in(resource_name, @resource)
        return render_create_success
      rescue ::Devise::Strategies::Authenticatable::InvalidPassword
        # We should never reach here unless there's an auth strategy issue
        Rails.logger.error "[SessionsController] Devise strategy error"
        return render json: { error: "Authentication strategy failed" }, status: :unauthorized
      rescue => e
        attempted_email = resource_params[:email]
        attempted_resource = User.find_by(email: attempted_email)

        if attempted_resource
          Rails.logger.debug "[SessionsController] inactive_message: #{attempted_resource.inactive_message.inspect}"
          Rails.logger.debug "[SessionsController] locked_at: #{attempted_resource.locked_at.inspect}"
          Rails.logger.debug "[SessionsController] failed_attempts: #{attempted_resource.failed_attempts}"
        end

        warden_msg = request.env["warden.options"]&.[](:message)
        Rails.logger.debug "[SessionsController] Warden options: #{warden_msg}"

        case warden_msg
        when :last_attempt
          return render json: { error: I18n.t("devise.failure.last_attempt"), reason: "last-attempt" }, status: :unauthorized
        when :locked
          return render json: { error: I18n.t("devise.failure.locked"), reason: :locked }, status: :unauthorized
        when :invalid
          return render json: { error: I18n.t("devise.failure.invalid") }, status: :unauthorized
        else
          return render json: { error: I18n.t("devise.failure.unauthenticated") }, status: :unauthorized
        end
      end
    end

    private

    def auth_options
      { scope: resource_name, recall: "#{controller_path}#new" }
    end
  end
end
