class AnswerTypesController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def create
    @answer_type = AnswerType.new(answer_type_params)
    if @answer_type.save
      render :json => @answer_type.to_json
    else
      render :json => { :errors => @answer_type.errors.full_messages }
    end
  end

  def update
    @answer_type = AnswerType.find(params[:id])
    if @answer_type.update_attributes(answer_type_params)
      render :json => @answer_type.to_json
    else
      render :json => { :errors => @answer_type.errors.full_messages }
    end
  end

  def destroy
    AnswerType.find(params[:id]).destroy
    render :json => true
  end

  private
  def answer_type_params
    params.require(:answer_type).permit(:label, :description,
                                        choices_attributes: [
                                          :id,
                                          :_destroy,
                                          :value,
                                          :text,
                                          :order
                                        ],
                                        answer_validation_attributes: [
                                          :id,
                                          :_destroy,
                                          :regular_expression
                                        ])
  end
end
