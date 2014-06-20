class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    if @answer.save
      flash[:success] = "Answer saved."
      redirect_to question_path(@question)
    else
      flash[:failure] = "An error occured. Answer not saved."
      render "new"
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = @question.Answer.find(params[:id])
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
    @answer = Answer.find(params[:id]).destroy
    flash[:success] = "Answer deleted."
    redirect_to(@answer.question)
  end

  private
    def answer_params
      params.require(:answer).permit(:value)
    end
end