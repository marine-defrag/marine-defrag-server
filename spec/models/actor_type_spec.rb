require "rails_helper"

RSpec.describe ActorType, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_many :actors }

  it "is expected to default has_members to nil" do
    expect(subject.has_members).to eq(nil)
  end

  it "is expected to default is_active to nil" do
    expect(subject.is_active).to eq(nil)
  end

  it "is expected to default is_target to nil" do
    expect(subject.is_target).to eq(nil)
  end
end
