require "rails_helper"

RSpec.describe Page, type: :model do
  it { is_expected.to validate_presence_of :title }

  it "is expected to default private to true" do
    expect(subject.private).to eq(true)
  end
end
