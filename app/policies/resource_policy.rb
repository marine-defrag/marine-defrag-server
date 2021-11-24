class ResourcePolicy < ApplicationPolicy
  def permitted_attributes
    [
      :access_date,
      :description,
      :draft,
      :private,
      :publication_date,
      :status,
      :title,
      :type_id,
      :url
    ]
  end
end
