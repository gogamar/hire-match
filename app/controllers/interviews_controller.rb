class InterviewsController < ApplicationController
  def index
    @interviews = policy_scope(Interview)
  end

  def show
    @interview = Interview.find(params[:id])
    authorize @interview
  end

  def new
    @job = Job.find(params[:job_id])
    @interview = Interview.new
    authorize @interview
  end

  def create
    @job = Job.find(params[:job_id])
    @interview = Interview.new(interview_params)
    @interview.job = @job
    authorize @interview

    if @interview.save
      redirect_to new_interview_question_path(@interview), notice: 'Interview was successfully created. Now you can create questions.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @interview = Interview.find(params[:id])
    authorize @interview
  end

  def update
    @interview = Interview.find(params[:id])
    authorize @interview

    if @interview.update(interview_params)
      redirect_to @interview, notice: 'Interview was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @interview = Interview.find(params[:id])
    authorize @interview
    @interview.destroy
    redirect_to interviews_url, notice: 'Interview was successfully destroyed.'
  end

  private

  def interview_params
    params.require(:interview).permit(:name, :job_id)
  end

end
