class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @interview = @question.interview
    @answer = Answer.new
    @candidate = Candidate.find_by(user_id: current_user.id)
    # if the question number is 1, we can assume it's the first question
    unless @question.number == 1
      @previous_question = @interview.questions.find_by(number: @question.number - 1)
      # find the answer of the previous question by the same candidate
      @previous_answer = @candidate.answers.find_by(question_id: @previous_question.id)
      @reaction = @previous_answer.reaction
    end
  end
end
