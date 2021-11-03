class MeasureActorSerializer
  include FastVersionedSerializer

  attributes(
    :actor_id,
    :created_by_id,
    :date_end,
    :date_start,
    :measure_id,
    :updated_by_id,
    :value
  )

  set_type :measure_actors
end
