class QuestionsController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def new
  	@question = Question.new
  end

  def create
  	@question = Question.new(question_params)
  	if @question.save
  	  flash[:notice] = "Question created succesfully."
  	  redirect_to questions_path
  	else
  	  render :action => 'new'
  	end
  end

  def show
  	@question = Question.find(params[:id])
  end

  def edit
  	@question = Question.find(params[:id])
  end

  def update
  	@question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to @question, notice: "Question updated!"
    else
      render 'edit'
    end
  end

  def index
  	@questions = Question.paginate(page: params[:page])
  end

  def destroy
    Question.find(params[:id]).destroy
    flash[:success] = "Question deleted."
    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:label, :text, :answer_type_id, :block_id)
  end
end
