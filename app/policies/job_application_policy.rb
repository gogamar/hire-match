class JobApplicationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        if user.candidate?
          scope.where(candidate: user.candidate)
        elsif user.company?
          scope.where(job: user.company.jobs)
        else
          scope.none
        end
      else
        scope.none
      end
    end
  end

  def show?
    return false unless user.present?

    if user.candidate?
      record.candidate == user.candidate
    elsif user.company?
      record.job.company == user.company
    else
      false
    end
  end
end
