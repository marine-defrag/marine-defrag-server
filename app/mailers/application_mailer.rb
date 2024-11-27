# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default(
    from: ENV["SMTP_FROM_NAME"] + "<" + ENV["SMTP_FROM"] + ">",
    reply_to: ENV["SMTP_FROM_NAME"] + "<" + ENV["SMTP_FROM"] + ">",
  )
  layout "mailer"
end
