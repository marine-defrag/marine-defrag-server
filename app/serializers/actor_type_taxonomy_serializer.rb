class ActorTypeTaxonomySerializer
  include FastApplicationSerializer

  attributes :actor_type_id, :taxonomy_id

  set_type :actor_type_taxonomies
end
