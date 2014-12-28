class StudiesController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin, only: [ :edit, :update, :destroy, :new, :create ]

  def create
    @study = Study.new(study_params)
    if @study.save
      render :json => @study.to_json
    else
      render :json => { :errors => @study.errors.full_messages }
    end
  end

  def show
    @study = Study.find(params[:id])
  end

  def update
    @study = Study.find(params[:id])
    if @study.update_attributes(study_params)
      render :json => @study.to_json
    else
      render :json => { :errors => @study.errors.full_messages }
    end
  end

  def index
    @studies = Study.paginate(page: params[:page])
  end

  def destroy
    Study.find(params[:id]).destroy
    flash[:success] = "Study deleted."
    redirect_to studies_path
  end

  private
  
  def study_params
    params.require(:study).permit(:title, :label)
  end
end
