class AnswerSet < ActiveRecord::Base
  belongs_to :participant
  belongs_to :questionnaire

  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, 
  	allow_destroy: true

  validates :participant, presence: true
  validates :questionnaire, presence: true

  def set_participant(participant)
    self.participant = participant
    self.answers.each do |answer|
      answer.participant = participant
    end
  end
end
