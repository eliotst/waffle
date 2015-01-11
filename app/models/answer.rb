class Answer < ActiveRecord::Base
  attr_accessor :values

  belongs_to :answer_set
  belongs_to :participant
  belongs_to :question

  validates :participant, presence: true
  validates :question, presence: true
  validate :check_answer

  after_validation :squash_values

  self.per_page = 10

  def check_answer
    if !self.values.nil?
      self.values.delete("")
      validate_multiple_values
    else
      validate_value
    end
  end

  def squash_values
    if !self.values.nil?
      self.value = self.values.join(",")
      puts "HERE: " + self.value
    end
  end

  def validate_multiple_values
    if question
      self.values.each do |single_value|
        if question and !question.check_answer(single_value)
          errors.add(:value, "Invalid answer: " + single_value)
        end
      end
    end
  end

  def validate_value
    if self.value.is_nil? or self.value.is_blank
      errors.add(:value, "Cannot be blank")
    elsif question and !question.check_answer(self.value)
      errors.add(:value, "Invalid answer: " + self.value)
    end
  end
end
