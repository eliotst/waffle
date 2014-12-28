class BlockQuestionnairesController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def create
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @block = Block.find(params[:block_id])
    @questionnaire.blocks.append(@block)
    if @questionnaire.save
      redirect_to @questionnaire, notice: "Questionnaire updated!"
    else
      redirect_to @questionnaire, notice: "Questionnaire not updated."
    end
  end
end
