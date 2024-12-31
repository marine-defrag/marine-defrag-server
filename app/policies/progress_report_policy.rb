# frozen_string_literal: true

class ProgressReportPolicy < ApplicationPolicy
  def permitted_attributes
    [:indicator_id, :title, :description, :document_url, :document_public, :draft,
      indicator_attributes: [:id, :title, :description, :draft]]
  end

  def create?
    super || @user.role?("admin") || @user.role?("manager")
  end

  def update?
    super
  end
end
