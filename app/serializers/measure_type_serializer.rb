class MeasureTypeSerializer
  include FastApplicationSerializer

  attributes(
    :has_parent,
    :has_target,
    :title
  )

  set_type :measure_types
end
