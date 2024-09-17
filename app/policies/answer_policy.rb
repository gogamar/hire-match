class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        if user.candidate?
          scope.where(candidate: user.candidate)
        elsif user.company?
          # Show answers for questions from interviews for jobs the company has
          scope.joins(question: { interview: :job }).where(job: { company: user.company })
        else
          scope.none
        end
      else
        scope.none
      end
    end
  end

  def create?
    user.present? && user.candidate?
  end
end
