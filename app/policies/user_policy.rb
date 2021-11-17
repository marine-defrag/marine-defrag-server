class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    @user.roles.none?
  end

  def edit?
    false
  end

  def update?
    @user.role?("admin") || @record.id == @user.id
  end

  def destroy?
    @user.role?("admin")
  end

  def permitted_attributes
    [:email, :password, :password_confirmation, :name]
  end

  class Scope < Scope
    def resolve
      return scope.all if @user.role?("admin") || @user.role?("manager")

      scope.where(id: @user.id)
    end
  end
end
