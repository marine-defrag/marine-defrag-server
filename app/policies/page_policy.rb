class PagePolicy < ApplicationPolicy
  def index?
    @user.roles.any?
  end

  def show?
    @user.roles.any?
  end

  def create?
    @user.role?("admin")
  end

  def edit?
    false
  end

  def update?
    @user.role?("admin")
  end

  def destroy?
    @user.role?("admin")
  end

  def permitted_attributes
    [:title, :content, :menu_title, :draft, :order]
  end

  class Scope < Scope
    def resolve
      return scope.all if @user.role?("admin") || @user.role?("manager")

      scope.where(draft: false)
    end
  end
end
