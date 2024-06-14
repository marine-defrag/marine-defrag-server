require "rails_helper"

RSpec.describe Feedback, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :subject }
  it { is_expected.to validate_presence_of :content }
end
