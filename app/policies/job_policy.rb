class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        if user.candidate?
          scope.all
        elsif user.company?
          scope.where(company: user.company)
        else
          scope.none
        end
      else
        scope.none
      end
    end
  end

  def show?
    user.present? && (user.candidate? || record.company == user.company)
  end

end
