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
    CSV.generate(options) do |csv|
      csv << Answer.column_names
      all.each do |answer_set|
        answer_set.answers.each do |answer|
          csv << answer.attributes.values_at(*Answer.column_names)
        end
      end
    end
  end
end
