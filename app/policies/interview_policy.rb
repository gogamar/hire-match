class InterviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.present?
  end

  def create?
    user.present? && user.company?
  end

  def new?
    create?
  end

  def update?
    user.present? && user == record.job.company.user
  end

  def edit?
    update?
  end
end
