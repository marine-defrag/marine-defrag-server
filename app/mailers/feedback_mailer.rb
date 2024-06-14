class FeedbackMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.created.subject
  #
  def created(feedback)
    return unless ENV["FEEDBACK_EMAIL_ADDRESS"]

    @feedback = feedback
    @user_name = feedback.user.name

    mail to: ENV.fetch("FEEDBACK_EMAIL_ADDRESS"), subject: feedback.subject + " " + I18n.t("feedback_mailer.created.subject"), from: feedback.user.email
  end
end
