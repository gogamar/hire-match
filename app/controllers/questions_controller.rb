class QuestionsController < ApplicationController
  def index
    @questions = policy_scope(Question)
  end

  def show
    @question = Question.find(params[:id])
    authorize @question
    @interview = @question.interview
    @answer = Answer.new
    @job_application = JobApplication.find_by(candidate: @current_candidate, job: @interview.job)
    # if the question number is 1, we can assume it's the first question
    unless @question.number == 1
      @previous_question = @interview.questions.find_by(number: @question.number - 1)
      # find the answer of the previous question by the same candidate
      @previous_answer = @job_application.answers.find_by(question_id: @previous_question.id)
      @reaction = @previous_answer.reaction
    end
  end

  private

  def next_question_number
    max_number = @interview.questions.maximum(:number) || 0
    max_number + 1
  end
end
