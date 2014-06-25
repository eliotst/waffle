class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new
    @answer.participant = Participant.find_by_user_id(current_user.id)
  end

  def create
    if logged_in?
      @question = Question.find(params[:question_id])
      @answer = @question.answers.create(answer_params)
      @answer.participant = Participant.find_by_user_id(current_user.id)
      if @answer.save
        flash[:success] = "Answer saved."
        redirect_to question_path(@question)
      else
        flash[:failure] = "An error occurred. Answer not saved."
        render "new"
      end
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = @question.Answer.find(params[:id])
    @answer.participant = Participant.find_by_user_id(current_user.id)
  end

  def index
    @answers = Answer.paginate(page: params[:page])
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.participant = Participant.find_by_user_id(current_user.id)
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.participant = Participant.find_by_user_id(current_user.id)
    if @answer.update_attributes(answer_params)
      redirect_to @answer, notice: "Answer Updated."
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id]).destroy
    @answer.participant = Participant.find_by_user_id(current_user.id)
    flash[:success] = "Answer deleted."
    redirect_to(@answer.question)
  end

  private
    def answer_params
      params.require(:answer).permit(:value)
    end
end