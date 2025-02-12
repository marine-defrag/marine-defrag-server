class PagePolicy < ApplicationPolicy
  def edit?
    false
  end

  def permitted_attributes
    [:title, :content, :menu_title, :draft, :order, :document_url, :private]
  end

  class Scope < Scope
    def resolve
      # If the user is not authenticated, only allow access to pages where private: false
      if @user.nil?
        scope.where(private: false)
      # If the user has one of the roles, return all pages
      elsif @user.role?("admin") || @user.role?("manager")
        scope.all
      # If the user is an analyst, restrict to non-draft pages
      elsif @user.role?("analyst")
        if scope.column_names.include?("draft")
          scope.where(draft: false)
        else
          scope.all
        end
      else
        # Default case: For users without roles, only return non-draft, non-archived, non-private pages
        scope.where(draft: false, is_archive: false, private: false)
      end
    end
  end
end
