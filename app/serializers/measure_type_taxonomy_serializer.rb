class MeasureTypeTaxonomySerializer
  include FastApplicationSerializer

  attributes :measure_type_id, :taxonomy_id

  set_type :measure_type_taxonomies
end
