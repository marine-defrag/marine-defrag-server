class ActorTypeTaxonomy < ApplicationRecord
  self.table_name = :actor_types_taxonomies

  belongs_to :actor_type
  belongs_to :taxonomy
end
