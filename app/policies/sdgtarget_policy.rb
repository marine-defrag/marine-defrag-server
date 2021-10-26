# frozen_string_literal: true

class SdgtargetPolicy < ApplicationPolicy
  def permitted_attributes
    [:title, :description, :reference, :draft]
  end
end
