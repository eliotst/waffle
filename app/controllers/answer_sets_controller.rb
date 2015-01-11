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
    @answer_sets = AnswerSet.paginate(page: params[:page])
  end

  def new
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @answer_set = @questionnaire.create_answer_set
  end

  def create
    @answer_set = AnswerSet.new(answer_set_params)

    begin
      participant = Participant.where(user_id: current_user.id,
                                      study_id: @answer_set.questionnaire.study_id).take
    rescue
      render "new", questionnaire_id: @answer_set.questionnaire.id
      return
    end
    @answer_set.set_participant(participant)

    if @answer_set.save
      redirect_to answer_sets_url
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
    params.require(:answer_set).permit(:questionnaire_id, answers_attributes:
                                       [ { values: [] }, :value, :question_id ])
  end
end
