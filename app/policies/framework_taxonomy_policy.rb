# frozen_string_literal: true

class FrameworkTaxonomyPolicy < SystemPolicy
  def permitted_attributes
    [:framework_id, :taxonomy_id]
  end
end
