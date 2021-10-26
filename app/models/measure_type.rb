# frozen_string_literal: true

class MeasureType < ApplicationRecord
  has_many :measures

  validates :title, presence: true
end
