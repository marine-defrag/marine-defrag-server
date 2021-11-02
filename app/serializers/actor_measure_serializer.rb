class ActorMeasureSerializer
  include FastVersionedSerializer

  attributes(
    :actor_id,
    :created_by_id,
    :measure_id,
    :date_start,
    :date_end,
    :updated_by_id,
    :value
  )

  set_type :actor_measures
end
