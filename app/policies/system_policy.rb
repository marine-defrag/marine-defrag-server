class SystemPolicy < ApplicationPolicy
  def create?
    false
  end

  def destroy?
    false
  end

  def update?
    false
  end

  class Scope < Scope
    def resolve
      scope.all if %w[admin analyst manager].any? { |role| @user.role?(role) }
    end
  end
end
