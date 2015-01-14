class ParticipantController < ApplicationController
  before_action :must_be_admin, except: [ :sign_up ]

  def sign_up
    @participant = Participant.new
    @participant.user = current_user
    @participant.study = Study.find(params[:study_id])

    if @participant.save
      redirect_to @participant
    else
      redirect_to root_url
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def index
    @participant = Participant.paginate(page: params[:page])
  end
end
