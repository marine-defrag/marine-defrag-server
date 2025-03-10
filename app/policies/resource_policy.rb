class ResourcePolicy < ApplicationPolicy
  def permitted_attributes
    [
      :access_date,
      :description,
      :draft,
      :document_url,
      :publication_date,
      :status,
      :title,
      :resourcetype_id,
      :url
    ]
  end
end
