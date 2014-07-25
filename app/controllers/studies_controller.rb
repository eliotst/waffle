class StudiesController < ApplicationController
  def new
    @study = Study.new
    questionnaire = @study.questionnaires.build
    questionnaire.blocks.build  
  end

  def create
    @study = Study.new(study_params)
    if @study.save
      flash[:notice] = "Study created succesfully."
      redirect_to @study
    else
      render :action => 'new'
    end
  end

  def show
    @study = Study.find(params[:id])
  end

  def edit
    @study = Study.find(params[:id])
  end

  def update
    @study = Study.find(params[:id])
    if @study.update_attributes(study_params)
      redirect_to @study, notice: "Study updated!"
    else
      render 'edit'
    end
  end

  def index
    @studies = Study.paginate(page: params[:page])
  end

  def destroy
    if current_user.admin?
      Study.find(params[:id]).destroy
      flash[:success] = "Study deleted."
      redirect_to studies_path
    else
      flash[:notice] = "Only admins may delete a study."
    end
  end

  private
  
  def study_params
    params.require(:study).permit(:title, questionnaires_attributes:
      [:label, :id, :_destroy, blocks_attributes: 
      [:label, :id, :_destroy, questions_attributes: 
      [:label, :id, :_destroy, :text, answers_attributes: 
      [:value, :id, :_destroy, :participant_id], choices_attributes: 
      [:value, :id, :_destroy]]]])
  end
end
