require "rails_helper"

RSpec.describe Indicator, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_many :measures }
  it { is_expected.to have_many :progress_reports }
  it { is_expected.to have_many :categories }
  it { is_expected.to have_many :recommendations }
  it { is_expected.to belong_to(:manager).optional }

  context "date field validations" do
    let!(:indicator_with_repeat) { FactoryBot.create(:indicator, :with_repeat) }
    let!(:indicator_without_repeat) { FactoryBot.create(:indicator, :without_repeat) }

    it "requires end_date only if repeat is set to true" do
      expect(indicator_with_repeat).to validate_presence_of :end_date
      expect(indicator_without_repeat).to_not validate_presence_of :end_date
    end

    it "requires frequency_months if repeat is set to true" do
      expect(indicator_with_repeat).to validate_presence_of :frequency_months
      expect(indicator_without_repeat).to_not validate_presence_of :frequency_months
    end

    it "requires end_date is greater than start_date if repeat is true" do
      indicator_with_repeat.end_date = indicator_with_repeat.start_date - 1.day
      expect(indicator_with_repeat).to be_invalid
      indicator_with_repeat.end_date = indicator_with_repeat.start_date + 1.day
      expect(indicator_with_repeat).to be_valid
    end
  end
end
