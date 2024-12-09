# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default(
    from: "Marine Litter Action Mapping Tool <notifications@marine-defrag.org>",
    reply_to: "Marine Litter Action Mapping Tool <notifications@marine-defrag.org>",
  )
  layout "mailer"
end
