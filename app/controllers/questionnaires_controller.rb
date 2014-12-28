class QuestionnairesController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    if @questionnaire.save
      render :json => @questionnaire.to_json
    else
      render :json => { :errors => @questionnaire.errors.full_messages }
    end
  end

  def update
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.update_attributes(questionnaire_params)
      render :json => @questionnaire.to_json
    else
      render :json => { :errors => @questionnaire.errors.full_messages }
    end
  end

  def destroy
    Questionnaire.find(params[:id]).destroy
    render :json => true
  end

  private
  def questionnaire_params
    params.require(:questionnaire).permit(:label, :study_id)
  end
end
