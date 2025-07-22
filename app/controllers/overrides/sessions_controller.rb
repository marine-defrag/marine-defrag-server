module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def create
      field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
      @resource = find_resource(field, resource_params[field])

      if @resource && valid_params?(field, resource_params[field]) && valid_password?(@resource, resource_params[:password])
        return render_create_success
      end

      # Handle specific failure reasons
      if @resource
        Rails.logger.debug "[Overrides::SessionsController] create called with inactive_message: #{@resource&.inactive_message.inspect}"
        case @resource.inactive_message
        when :locked
          return render json: { error: I18n.t("devise.failure.locked"), reason: @resource.inactive_message }, status: :unauthorized
        when :archived
          return render json: { error: I18n.t("devise.failure.archived"), reason: @resource.inactive_message }, status: :unauthorized
        end
      end

      if request.env["warden.options"] && request.env["warden.options"][:message] == :last_attempt
        return render json: { error: I18n.t("devise.failure.last_attempt"), reason: "last-attempt" }, status: :unauthorized
      end

      render json: { error: I18n.t("devise.failure.invalid") }, status: :unauthorized
    end
  end
end
