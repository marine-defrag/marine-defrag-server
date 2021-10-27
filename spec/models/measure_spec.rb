require "rails_helper"

RSpec.describe Measure, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_many :recommendations }
  it { is_expected.to have_many :categories }
  it { is_expected.to have_many :indicators }
  it { is_expected.to have_many :due_dates }
  it { is_expected.to have_many :progress_reports }

  context "parent_id" do
    subject do
      described_class.create(title: "test", measure_type: FactoryBot.create(:measure_type, :parent_allowed))
    end

    it "can't be the record's ID" do
      subject.parent_id = subject.id
      expect(subject).to be_invalid
      expect(subject.errors[:parent_id]).to(include("can't be the same as id"))
    end

    it "can't be set to a measure with measure_type.has_parent = false" do
      subject.parent_id = described_class.create(
        title: "no parent",
        measure_type: FactoryBot.create(:measure_type, :parent_not_allowed)
      ).id
      expect(subject).to be_invalid
      expect(subject.errors[:parent_id]).to(include("is not allowed for this measure_type"))
    end

    it "can be set to a measure with measure_type.has_parent = true" do
      subject.parent_id = described_class.create(
        title: "no parent",
        measure_type: FactoryBot.create(:measure_type, :parent_allowed)
      ).id
      expect(subject).to be_valid
    end
  end
end
