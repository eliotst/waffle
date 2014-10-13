class Answer < ActiveRecord::Base
  belongs_to :participant
  belongs_to :question

  validates :participant,
    presence: true
  validates :value,
    presence: true
  validates :question,
    presence: true
  validate :check_answer

  self.per_page = 10

  def check_answer
    if question and !question.check_answer(value)
      errors.add(:value, "Invalid value")
    end
  end
end
