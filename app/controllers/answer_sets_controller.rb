class AnswerSetsController < ApplicationController
  before_action :must_be_logged_in
  before_action :must_be_admin, only: [ :destroy, :index ]

  def show
    @answer_set = AnswerSet.find(params[:id])
    if @answer_set == nil or
      (@answer_set.participant.user_id != current_user.id and !is_admin_user?)
      redirect_to root_url
    else
      @answer_set
    end
  end

  def index
    @answer_sets = AnswerSet.all
    respond_to do |format|
      format.html
      format.csv { send_data @answer_sets.to_csv }
    end
  end

  def new
    @schedule_entry = ScheduleEntry.find(params[:schedule_entry_id])
    if !@schedule_entry.taken
      @questionnaire = @schedule_entry.questionnaire
      participant = get_participant(current_user.id,
                                    @questionnaire.study.id)
      if !participant.nil?
        @answer_set = @questionnaire.create_answer_set
        @answer_set.schedule_entry = @schedule_entry
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

  def create
    puts params
    puts answer_set_params
    @answer_set = AnswerSet.new(answer_set_params)

    begin
      participant = get_participant(current_user.id,
                                    @answer_set.questionnaire.study_id)
    rescue
      render "new", questionnaire_id: @answer_set.questionnaire.id
      return
    end
    @answer_set.set_participant(participant)

    if @answer_set.save
      @answer_set.schedule_entry.sent = true
      @answer_set.schedule_entry.save
      redirect_to participant.user
    else
      render "new"
    end
  end

  def destroy
    @answer_set = AnswerSet.find(params[:id])

    @answer_set.destroy
    redirect_to answer_sets_url
  end

  private
  def answer_set_params
    params.require(:answer_set).permit(:questionnaire_id, :schedule_entry_id,
                                       answers_attributes:
                                       [ { values: [] }, :value, :question_id ])
  end

  def get_participant(user_id, study_id)
      Participant.where(user_id: user_id, study_id: study_id).take
  end
end
