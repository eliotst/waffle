class QuestionsController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def create
  	@question = Question.new(question_params)
  	if @question.save
      render :json => @question.to_json
    else
      render :json => { :errors => @question.errors.full_messages }
  	end
  end

  def update
  	@question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      render :json => @question.to_json
    else
      render :json => { :errors => @question.errors.full_messages }
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    render :json => true
  end

  private
  def question_params
    params.require(:question).permit(:label, :text, :answer_type_id,
                                     :block_id, :number)
  end
end
