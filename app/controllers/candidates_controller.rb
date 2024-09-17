class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:like, :unlike, :favorite_jobs]

  def index
    @candidates = policy_scope(Candidate)
    if params[:job_id].present?
      @job = Job.find(params[:job_id])
      @job_applications = @job.job_applications
      candidate_ids = @job_applications.pluck(:candidate_id)
      @candidates = @candidates.where(id: candidate_ids)
    end
  end

  def show
    @candidate = Candidate.find(params[:id])
    authorize @candidate
  end

  def favorite_jobs
    job_ids = @candidate.likes.pluck(:job_id)
    @favorite_jobs = Job.where(id: job_ids)
    @color = "cyan"
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
    authorize @candidate
  end

  def candidate_params
    params.require(:candidate).permit(:name, :surname)
  end
end
