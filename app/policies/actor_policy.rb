# frozen_string_literal: true

class ActorPolicy < ApplicationPolicy
  def permitted_attributes
    [
      :activity_summary,
      :actortype_id,
      :code,
      :description,
      :draft,
      :gdp,
      :population,
      :title,
      :url
    ]
  end
end
