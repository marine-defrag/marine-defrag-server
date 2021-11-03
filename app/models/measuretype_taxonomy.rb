class MeasuretypeTaxonomy < ApplicationRecord
  self.table_name = :measuretypes_taxonomies

  belongs_to :measuretype
  belongs_to :taxonomy
end
