class AnswerTypesController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def new
    @answer_type = AnswerType.new
  end

  def create
    @answer_type = AnswerType.new(answer_type_params)
    if @answer_type.save
      flash[:notice] = "Answer type created succesfully."
      redirect_to answer_types_path
    else
      render :action => 'new'
    end
  end

  def show
    @answer_type = AnswerType.find(params[:id])
  end

  def edit
    @answer_type = AnswerType.find(params[:id])
  end

  def update
    @answer_type = AnswerType.find(params[:id])
    if @answer_type.update_attributes(answer_type_params)
      redirect_to @answer_type, notice: "Answer type updated!"
    else
      render 'edit'
    end
  end

  def index
    @answer_types = AnswerType.paginate(page: params[:page])
  end

  def destroy
    AnswerType.find(params[:id]).destroy
    flash[:success] = "Answer type deleted."
    redirect_to answer_types_path
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
