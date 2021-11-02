# frozen_string_literal: true

class ActorMeasurePolicy < SystemPolicy
  def permitted_attributes
    [:actor_id, :measure_id, :date_start, :date_end, :value]
  end
end
