class ScheduleTemplatesController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin

  def create
    @schedule_template = ScheduleTemplate.new(schedule_template_params)
    if @schedule_template.save
      render :json => @schedule_template.to_json
    else
      render :json => { :errors => @schedule_template.errors.full_messages }
    end
  end

  def update
    @schedule_template = ScheduleTemplate.find(params[:id])
    if @schedule_template.update_attributes(schedule_template_params)
      render :json => @schedule_template.to_json
    else
      render :json => { :errors => @schedule_template.errors.full_messages }
    end
  end

  def destroy
    ScheduleTemplate.find(params[:id]).destroy
    render :json => true
  end

private
  def schedule_template_params
    params.require(:schedule_template).permit(:study_id, schedule_template_entries_attributes: [
                                          :id,
                                          :_destroy,
                                          :questionnaire_id,
                                          :time_offset_hours
                                        ])
  end
end
