class Feedback < ApplicationRecord
  belongs_to :user, required: true

  validates :subject, presence: true
  validates :content, presence: true
end
