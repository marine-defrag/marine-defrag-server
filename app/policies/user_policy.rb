class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    @record.id == @user.id || super
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
    false
  end

  def permitted_attributes
    attrs = [:email, :password, :password_confirmation, :name]
    attrs << [:is_archived] if @user.role?("admin")
    attrs
  end

  class Scope < Scope
    def resolve
      return scope.all if @user.role?("admin") || @user.role?("manager")

      scope.where(id: @user.id)
    end
  end
end
