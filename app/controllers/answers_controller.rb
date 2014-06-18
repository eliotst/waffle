class AnswersController < ApplicationController
  def new(question_id)
    @question = Question.find(params[:question_id])
    @answer = @question.answer.new
  end

  def create(question_id)
    @question = Question.find(params[:question_id]
    @answer = @question.answer.build(answer_params)
    if @answer.save
      flash[:success] = "Answer saved."
      redirect_to questions_path
    else
      flash[:failure] = "An error occured. Answer not saved."
      render "new"
    end
  end

  def index
    @answers = Answer.paginate(page: params[:page])
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(answer_params)
      redirect_to @answer, notice: "Answer Updated."
    else
      render 'edit'
    end
  end

  def destroy
    Answer.find(params[:id]).destroy
    flash[:success] = "Answer deleted."
    redirect_to answers_path
  end

  private
    def answer_params
      params.require(:answer).permit(:value)
    end
end