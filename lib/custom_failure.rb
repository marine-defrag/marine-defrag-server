# lib/custom_failure.rb
class CustomFailure < Devise::FailureApp
  def respond
    json_api_error_response
  end

  def json_api_error_response
    message = i18n_message

    # Try to find the resource to customize the message
    user = find_user_from_request

    if user
      case user.inactive_message
      when :archived
        message = I18n.t("devise.failure.archived")
      when :locked
        message = I18n.t("devise.failure.locked")
      when :last_attempt
        message = I18n.t("devise.failure.last_attempt")
      end
    end

    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { success: false, errors: [message] }.to_json
  end

  private

  def find_user_from_request
    # Attempt to find user from the request parameters (email)
    params = request.params
    email = params.dig("email") || params.dig("user", "email")
    return nil unless email

    User.find_by(email: email)
  end
end
