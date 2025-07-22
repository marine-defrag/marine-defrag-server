# lib/custom_failure.rb
class CustomFailure < Devise::FailureApp
  def respond
    Rails.logger.debug "[CustomFailure] respond called"
    puts "[CustomFailure] respond called"
    json_api_error_response
  end

  def json_api_error_response
    message = i18n_message
    warden_opts = warden_options

    Rails.logger.debug "[CustomFailure] warden_options: #{warden_opts.inspect}"
    Rails.logger.debug "[CustomFailure] i18n_message: #{message.inspect}"

    user = find_user_from_request

    if user
      Rails.logger.debug "[CustomFailure] Found user: #{user.email}"
      Rails.logger.debug "[CustomFailure] locked_at: #{user.locked_at}"
      Rails.logger.debug "[CustomFailure] failed_attempts: #{user.failed_attempts}"
      Rails.logger.debug "[CustomFailure] inactive_message: #{user.inactive_message}"

      case user.inactive_message
      when :archived
        message = I18n.t("devise.failure.archived")
      when :locked
        message = I18n.t("devise.failure.locked")
      when :last_attempt
        message = I18n.t("devise.failure.last_attempt")
      end
    else
      Rails.logger.debug "[CustomFailure] No user found for email in request"
    end

    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { success: false, errors: [message] }.to_json
  end

  private

  def find_user_from_request
    params = request.params
    email = params.dig("email") || params.dig("user", "email") || params.dig("session", "email")
    Rails.logger.debug "[CustomFailure] Extracted email: #{email}"
    return nil unless email

    User.find_by(email: email)
  end
end
