class ParticipantsController < ApplicationController
  before_action :must_be_admin, except: [ :create, :new ]

  def new
    @study = Study.find(params[:study_id])
    @participant = Participant.new
    @participant.study_id = @study.id
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.user = current_user

    if @participant.agree == "true" and @participant.save
      redirect_to current_user
    else
      redirect_to root_url
    end
  end

  def index
    @participant = Participant.paginate(page: params[:page])
  end

  private
  def participant_params
    params.require(:participant).permit(:study_id, :agree)
  end
end
