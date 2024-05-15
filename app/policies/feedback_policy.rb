class FeedbackPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    false
  end

  def create?
    @user.roles.any?
  end

  def edit?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def permitted_attributes
    [:subject, :content, :user_id]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
