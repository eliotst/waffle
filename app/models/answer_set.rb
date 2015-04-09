class AnswerSet < ActiveRecord::Base
  belongs_to :participant
  belongs_to :questionnaire
  belongs_to :schedule_entry

  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, 
  	allow_destroy: true

  validates :participant, presence: true
  validates :questionnaire, presence: true
  validates :schedule_entry, presence: true
  validate :one_per_schedule_entry

  def set_participant(participant)
    self.participant = participant
    self.answers.each do |answer|
      answer.participant = participant
    end
  end

  def one_per_schedule_entry
    if !self.schedule_entry.nil? and self.schedule_entry.taken
      errors.add(:questionnaire, "That questionnaire has already been completed.")
    end
  end

  def self.to_csv(options = {})
    offset_order_map = {
      0 => 0,
      2 => 1,
      24 => 2,
      48 => 3,
      72 => 4
    }
    CSV.generate(options) do |csv|
      answers = Answer.all
      participants = {}
      # build a mapping of participants' answers
      answers.each do |answer|
        participant_id = answer.participant_id
        if participants[participant_id] == nil
          participants[participant_id] = {}
        end

        participant = participants[participant_id]
        sign_up_date = answer.participant.created_at

        question = answer.question

        difference = (answer.answer_set.schedule_entry.time_to_send - sign_up_date)
        hours = (difference / 1.hour).round

        questionnaire_index = offset_order_map[hours]

        answer_type = answer.question.answer_type
        if answer_type.allow_multiple
          answer_values = answer.value.split(",")
          answer_values.each do |value|
            choice = Choice.where(text: value,
                                  answer_type: answer_type).take
            label = question.label + "_" + choice.label + "_" + questionnaire_index
            participant[label] = 1
          end
        else
          label = question.label + "_" + questionnaire_index
          if answer_type.answer_validation != nil
            choice = Choice.where(text: answer.value,
                                  answer_type: answer_type).take
            participant[label] = choice.order
          else
            participant[label] = answer.value
          end
        end
      end

      columns = []
      schedule_template_entries = ScheduleTemplateEntry.order(time_offset_hours: asc)
      
      schedule_template_entries.each do |template_entry|
        questionnaire = template_entry.questionnaire
        questions = questionnaire.questions.order(number: asc)

        questionnaire_index = offset_order_map[template_entry.time_offset_hours]

        questions.each do |question|
          if questions.answer_type.allow_multiple
            choices = questions.answer_type.choices
            choices.each do |choice|
              columns.push(question.label + "_" + choice.label + "_" + questionnaire_index)
            end
          else
            columns.push(question.label + "_" + questionnaire_index)
          end
        end
      end

      csv << columns

      participants.each do |participant|
        csv << participant.values_at(*columns)
      end
    end
  end
end
