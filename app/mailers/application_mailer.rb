# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default(
    from: "Marine Litter Action Mapping Tool <support@marine-defrag.org>",
    reply_to: "Marine Litter Action Mapping Tool <support@marine-defrag.org>",
  )
  layout "mailer"
end
