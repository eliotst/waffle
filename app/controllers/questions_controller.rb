class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question saved."
      render "new"
    else
      flash[:failure] = "An error occured. Question not saved."
      render "new"
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.paginate(page: params[:page])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to @question, notice: "Question Updated."
    else
      render 'edit'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    flash[:success] = "Question deleted."
    redirect to #
  end

  private
    def question_params
      params.require(:question).permit(:text, :label)
    end
end