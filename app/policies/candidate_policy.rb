class CandidatePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        if user.candidate?
          scope.where(id: user.company.id)
        elsif user.company? || user.admin?
          scope.all
        else
          scope.none
        end
      else
        scope.none
      end
    end
  end

  def show?
    true
  end

  def create?
    # Restrict direct creation, allow only via the callback mechanism
    false
  end

  def update?
    user.present? && user == record.user
  end

  def edit?
    update?
  end

  def favorite_jobs?
    user.present? && user.candidate?
  end
end
