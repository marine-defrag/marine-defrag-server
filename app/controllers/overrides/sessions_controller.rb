module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def create
      # Attempt to authenticate the user via Warden (Devise)
      self.resource = warden.authenticate!(scope: resource_name)

      # Successful authentication, proceed as usual
      render_create_success
    rescue ::Warden::NotAuthenticated => e
      # Authentication failed — find the resource (user) to check locking or inactive reasons
      field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
      @resource = find_resource(field, resource_params[field])

      if @resource
        Rails.logger.debug "[Overrides::SessionsController] create called with inactive_message: #{@resource&.inactive_message.inspect}"
        Rails.logger.debug "[Overrides::SessionsController] locked_at: #{@resource&.locked_at.inspect}"
        Rails.logger.debug "[Overrides::SessionsController] Warden options: #{request.env['warden.options'].inspect}"

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
