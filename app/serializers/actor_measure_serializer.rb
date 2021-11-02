class ActorMeasureSerializer
  include FastApplicationSerializer

  attributes :actor_id, :measure_id, :date_start, :date_end, :value

  set_type :actor_measures
end
