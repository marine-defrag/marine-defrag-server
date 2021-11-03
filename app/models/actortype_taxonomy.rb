class ActortypeTaxonomy < ApplicationRecord
  self.table_name = :actortypes_taxonomies

  belongs_to :actortype
  belongs_to :taxonomy
end
