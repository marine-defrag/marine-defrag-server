require "rails_helper"

RSpec.describe Actor, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to belong_to :actor_type }

  it "is expected to default private to true" do
    expect(subject.private).to eq(true)
  end

  it "is expected to default draft to true" do
    expect(subject.draft).to eq(true)
  end
end
