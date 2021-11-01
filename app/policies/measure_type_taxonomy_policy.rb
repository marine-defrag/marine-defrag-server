# frozen_string_literal: true

class MeasureTypeTaxonomyPolicy < SystemPolicy
  def permitted_attributes
    [:measure_type_id, :taxonomy_id]
  end
end
