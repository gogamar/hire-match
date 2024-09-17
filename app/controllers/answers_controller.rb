class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    authorize @answer

    @answer.question = @question
    @interview = @question.interview
    @job = @interview.job

    @job_application = JobApplication.find_or_create_by(job_id: @job.id, candidate_id: @current_candidate.id) do |application|
      application.status = "unfinished"
    end

    @answer.job_application = @job_application

    if @answer.save
      openai_service = OpenaiService.new(ENV['OPENAI_API_KEY'])
      reaction = openai_service.generate_reaction(@answer.content)
      @answer.update(reaction: reaction)

      next_question = @interview.questions.find_by(number: @question.number + 1)
      if next_question
        redirect_to question_path(next_question)
      else
        # No more questions, update the JobApplication status to finished
        @job_application.update(status: 'finished')
        redirect_to root_path, notice: "Interview completed and job application submitted."
      end
    else
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id, :candidate_id, :reaction)
  end

  def find_or_create_job_application
    job_application = JobApplication.find_by(candidate_id: @current_candidate.id, job_id: @job.id)

    unless job_application
      job_application = JobApplication.create(candidate_id: @current_candidate.id, job_id: @job.id, status: 'unfinished')
    end

    job_application
  end
end
