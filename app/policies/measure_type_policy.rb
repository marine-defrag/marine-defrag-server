# frozen_string_literal: true

class MeasureTypePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if %w[admin analyst manager].any? { |role| @user.role?(role) }
    end
  end
end
