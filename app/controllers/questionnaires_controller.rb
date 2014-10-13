class QuestionnairesController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def new
    @questionnaire = Questionnaire.new
    block = @questionnaire.blocks.build
    block.questions.build  
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    if @questionnaire.save
      flash[:notice] = "Questionnaire created succesfully."
      redirect_to questionnaires_path
    else
      render :action => 'new'
    end
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
  end

  def edit
    @questionnaire = Questionnaire.find(params[:id])
  end

  def update
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.update_attributes(questionnaire_params)
      redirect_to @questionnaire, notice: "Questionnaire updated!"
    else
      render 'edit'
    end
  end

  def index
    @questionnaires = Questionnaire.paginate(page: params[:page])
  end

  def destroy
    if current_user.admin?
      Questionnaire.find(params[:id]).destroy
      flash[:success] = "Questionnaire deleted."
      redirect_to questionnaires_path
    else
      flash[:notice] = "Only admins may delete a block."
    end
  end

  private
  def questionnaire_params
    params.require(:questionnaire).permit(:label)
  end
end
