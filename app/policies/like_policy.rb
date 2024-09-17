class LikePolicy < ApplicationPolicy
  def create?
    user.present? && record.candidate == user.candidate
  end

  def update?
    user.present? && user.company.jobs.include?(record.job)
  end

  def destroy?
    create?
  end
end
