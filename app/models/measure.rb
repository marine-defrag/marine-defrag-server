# frozen_string_literal: true

class Measure < VersionedRecord
  has_many :recommendation_measures, inverse_of: :measure, dependent: :destroy
  has_many :sdgtarget_measures, inverse_of: :measure, dependent: :destroy
  has_many :measure_categories, inverse_of: :measure, dependent: :destroy
  has_many :measure_indicators, inverse_of: :measure, dependent: :destroy

  has_many :recommendations, through: :recommendation_measures, inverse_of: :measures
  has_many :categories, through: :measure_categories, inverse_of: :measures
  has_many :indicators, through: :measure_indicators, inverse_of: :measures
  has_many :due_dates, through: :indicators
  has_many :progress_reports, through: :indicators

  belongs_to :measure_type, required: true
  belongs_to :parent, class_name: "Measure", required: false

  accepts_nested_attributes_for :recommendation_measures
  accepts_nested_attributes_for :measure_categories

  validates :title, presence: true
  validates :measure_type_id, presence: true
  validate :different_parent, :parent_id_allowed_by_measure_type

  private

  def different_parent
    if parent_id && parent_id == id
      errors.add(:parent_id, "can't be the same as id")
    end
  end

  def parent_id_allowed_by_measure_type
    if parent_id && !parent.measure_type&.has_parent
      errors.add(:parent_id, "is not allowed for this measure_type")
    end
  end
end
