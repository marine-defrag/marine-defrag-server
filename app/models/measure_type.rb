# frozen_string_literal: true

class MeasureType < VersionedRecord
  has_many :measures

  validates :title, presence: true
end
