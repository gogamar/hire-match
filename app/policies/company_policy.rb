class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        if user.company?
          scope.where(id: user.company.id)
        elsif user.candidate? || user.admin?
          scope.all
        else
          scope.none
        end
      else
        scope.none
      end
    end
  end

  def create?
    # Restrict direct creation, allow only via the callback mechanism
    false
  end

  def show?
    if user.present?
      user.company? && record.id == user.company.id || user.candidate? || user.admin?
    else
      false
    end
  end

  def update?
    user.present? && (user.company? && record.id == user.company.id) || user.admin?
  end

  def destroy?
    user.present? && (user.company? && record.id == user.company.id) || user.admin?
  end

  def published_jobs?
    user.present? && (user.company? && record.id == user.company.id) || user.admin?
  end
end
