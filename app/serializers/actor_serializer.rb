class ActorSerializer
  include FastVersionedSerializer

  attributes(
    :activity_summary,
    :actor_type_id,
    :code,
    :description,
    :draft,
    :gdp,
    :population,
    :private,
    :title,
    :url
  )

  set_type :actors
end
