class MeasureResourceSerializer
  include FastApplicationSerializer

  attributes :measure_id, :resource_id

  set_type :measure_resources
end
