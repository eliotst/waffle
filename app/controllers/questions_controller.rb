class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question saved."
      redirect_to questions_path
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
    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:text, :label, answers_attributes:
        [:value, :id, :participant_id, :_destroy], choices_attributes:
        [:value, :id, :_destroy])
    end
end