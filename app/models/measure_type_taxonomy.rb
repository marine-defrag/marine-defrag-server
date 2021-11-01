class MeasureTypeTaxonomy < ApplicationRecord
  self.table_name = :measure_types_taxonomies

  belongs_to :measure_type
  belongs_to :taxonomy
end
