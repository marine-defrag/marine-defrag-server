class ActorCategorySerializer
  include FastApplicationSerializer

  attributes :actor_id, :category_id

  set_type :actor_categories
end
