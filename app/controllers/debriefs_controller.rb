class DebriefsController < ApplicationController
  def new
    @debrief = Debrief.where(user_id: current_user.id).first
    if @debrief == nil
      @debrief = Debrief.new
    end
  end

  def create
    @debrief = Debrief.new(debrief_params)
    @debrief.user = current_user
    @debrief.save
    redirect_to current_user
  end

  def update
    @debrief = Debrief.where(user_id: current_user.id).first
    if @debrief.update_attributes(debrief_params)
      @debrief.user = current_user
      @debrief.save
    end
    redirect_to current_user
  end

  private
  def debrief_params
      params.require(:debrief).permit(:choice, :instructor, :student_name)
  end
end
