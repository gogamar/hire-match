class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:edit, :update]

  def index
    @candidates = Candidate.all
  end

  def edit
    # Ensure user is the owner of the candidate record
    redirect_to root_path unless current_user.candidate == @candidate
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to root_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_candidate
    @candidate = current_user.candidate
  end

  def candidate_params
    params.require(:candidate).permit(:name, :surname)
  end
end
