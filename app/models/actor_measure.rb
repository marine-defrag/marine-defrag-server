class ActorMeasure < ApplicationRecord
  self.table_name = :actors_measures

  belongs_to :actor
  belongs_to :measure
end
