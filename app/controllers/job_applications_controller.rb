class JobApplicationsController < ApplicationController
  def index
    @job_applications = policy_scope(JobApplication)
    @jobs = Job.where(id: @job_applications.pluck(:job_id))
    @color = "blue"
  end

  def show
    @job_application = JobApplication.find(params[:id])
    @candidate = @job_application.candidate
    authorize @job_application
    @job = @job_application.job
  end
end
