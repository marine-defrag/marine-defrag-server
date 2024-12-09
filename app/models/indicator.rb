class Indicator < VersionedRecord
  validates :title, presence: true
  validates :end_date, presence: true, if: :repeat?
  validates :frequency_months, presence: true, if: :repeat?
  validate :end_date_after_start_date, if: :end_date?

  has_many :measure_indicators, inverse_of: :indicator, dependent: :destroy
  has_many :recommendation_indicators, inverse_of: :indicator, dependent: :destroy
  has_many :recommendations, through: :recommendation_indicators
  has_many :progress_reports
  has_many :measures, through: :measure_indicators, inverse_of: :indicators
  has_many :categories, through: :measures
  has_many :recommendations, through: :measures

  # not sure we need this?
  # has_many :direct_recommendations, through: :indicators_recommendations, source: :recommendation

  belongs_to :manager, class_name: "User", foreign_key: :manager_id, required: false

  accepts_nested_attributes_for :measure_indicators

  private

  def end_date_after_start_date
    if start_date > end_date
      errors.add(:end_date, "must be after start_date")
    end
  end
end
