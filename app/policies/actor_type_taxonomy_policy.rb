# frozen_string_literal: true

class ActorTypeTaxonomyPolicy < SystemPolicy
  def permitted_attributes
    [:actor_type_id, :taxonomy_id]
  end
end
