class ScheduleTemplatesController < ApplicationController
  def new
    @schedule_template = Schedule_template.new
  end

  def create
    @schedule_template = Schedule_template.new(schedule_template_params)
    if @schedule_template.save
      flash[:notice] = "Schedule template created succesfully."
      redirect_to schedule_templates_path
    else
      render :action => 'new'
    end
  end

  def edit
    @schedule_template = Schedule_template.find(params[:id])
  end

  def update
    @schedule_template = Schedule_template.find(params[:id])
    if @schedule_template.update_attributes(schedule_template_params)
      redirect_to @schedule_template, notice: "Schedule Template updated!"
    else
      render 'edit'
    end
  end

  def index
    @schedule_template = Schedule_template.paginate(page: params[:page])
  end

  def show
    if current_user.admin?
      @schedule_template = Schedule_template.find(params[:id])
    else
      flash[:notice] = "Only admins may look at details of a schedule template."
    end
  end

private
  def schedule_template_params
    params.require(:schedule_template).permit(:schedule_template_entries)
  end

end
