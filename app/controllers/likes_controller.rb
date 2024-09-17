class LikesController < ApplicationController
  before_action :set_job, only: [:create, :update]

  def create
    @like = @current_candidate.likes.build(job: @job)
    authorize @like

    if @like.save
      redirect_to jobs_path, notice: "You have added #{@job.title} to your favorites."
    else
      redirect_to jobs_path, notice: "Failed to add the job to your favorites."
    end
  end

  def update
    @job = Job.find(params[:job_id])
    @like = @job.likes.find(params[:id])
    authorize @like

    if @like
      @like.update(match: !@like.match)
      notice_message = @like.match ? "You have added #{@like.candidate.name} to your favorites." : "You have removed #{@like.candidate.name} from your favorites."
      redirect_to root_path, notice: notice_message
    else
      redirect_to root_path, alert: 'Failed to update the like status.'
    end
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like
    @job = @like.job

    if @like
      @like.destroy
      redirect_to jobs_path, notice: "You have removed #{@job.title} from favorites."
    else
      redirect_to jobs_path, alert: 'Failed to remove like.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def like_params
    params.require(:like).permit(:job_id, :candidate_id, :match)
  end
end
