# frozen_string_literal: true

class ActorPolicy < ApplicationPolicy
  def permitted_attributes
    [
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
    ]
  end
end
