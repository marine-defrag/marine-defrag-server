class BookmarkPolicy < ApplicationPolicy
  def create?
    index?
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def permitted_attributes
    [:user_id, :title, :view]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
