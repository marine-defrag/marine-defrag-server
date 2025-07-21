# app/controllers/overrides/sessions_controller.rb
module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    protected

    def render_create_error_not_confirmed
      render_authentication_error
    end

    def render_create_error
      render_authentication_error
    end

    private

    def render_authentication_error
      message = error_message_for(@resource)

      render json: {
        success: false,
        errors: [message]
      }, status: :unauthorized
    end

    def error_message_for(resource)
      return I18n.t("devise.failure.invalid") unless resource
      
      return I18n.t("devise.failure.archived") if resource&.inactive_message == :archived

      case resource&.inactive_message
      when :locked
        return I18n.t("devise.failure.locked")
      when :last_attempt
        return I18n.t("devise.failure.last_attempt")
      end

      I18n.t("devise.failure.#{resource&.inactive_message}", default: I18n.t("devise.failure.invalid"))
    end

    def warden_message
      request.env.dig("warden.options", :message)
    end
  end
end
