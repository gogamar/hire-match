class JobsController < ApplicationController
  before_action :set_job, only: [:show]

  def index
    @jobs = policy_scope(Job).joins(:interview).distinct
    # if a candidate is logged in, show only jobs that they have not applied to
    if @current_candidate
      @jobs = @jobs.where.not(id: @current_candidate.job_applications.pluck(:job_id))
    end
  end

  def show
  end

  private

  def set_job
    @job = Job.find(params[:id])
    authorize @job
  end
end
