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
end
