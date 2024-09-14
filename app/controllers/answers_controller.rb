class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    @answer.question_id = @question.id
    @answer.candidate_id = Candidate.find_by(user_id: current_user.id)&.id
    if @answer.save
      # Initialize the OpenAI service with your API key
      openai_service = OpenaiService.new(ENV['OPENAI_API_KEY'])
      reaction = openai_service.generate_reaction(@answer.content)
      # Save the reaction to the answer or perform any other action with it
      @answer.update(reaction: reaction)

      @interview = @question.interview
      next_question = @interview.questions.find_by(number: @answer.question.number + 1)
      if next_question
        redirect_to question_path(next_question)
      else
        redirect_to root_path, notice: "Interview completed"
      end
    else
      @question = Question.find(@answer.question_id)
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id, :candidate_id, :reaction)
  end
end
