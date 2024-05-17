class FeedbackMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.created.subject
  #
  def created(feedback)
    return unless ENV["FEEDBACK_EMAIL_ADDRESS"]

    @feedback = feedback

    mail to: ENV.fetch("FEEDBACK_EMAIL_ADDRESS"), subject: I18n.t("feedback_mailer.created.subject")
  end
end