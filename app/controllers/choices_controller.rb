class ChoicesController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @choice = @question.choices.new
  end

  def create
    if logged_in?
      @question = Question.find(params[:question_id])
      @choice = @question.choices.create(choice_params)
      if @choice.save
        flash[:success] = "Answer choice saved."
        redirect_to question_path(@question)
      else
        flash[:failure] = "An error occurred. Answer choice not saved."
        render "new"
      end
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @choice = @question.choices.find(params[:id])
  end

  def index
    @question = Question.find(params[:question_id])
    @choices = Choice.paginate(page: params[:page])
  end

  def edit
    @question = Question.find(params[:question_id])
    @choice = @question.choices.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @choice = @question.choices.find(params[:id])
    if @choice.update_attributes(choice_params)
      redirect_to @question, notice: "Answer choice updated."
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @choice = @question.choices.find(params[:id])
    @choice.destroy
    flash[:success] = "Answer choice deleted."
    redirect_to(@choice.question)
  end

  private
    def choice_params
      params.require(:choice).permit(:value)
    end
end