class AnswerType < ActiveRecord::Base
  has_many :choices, dependent: :destroy
  has_one :answer_validation, dependent: :destroy

  accepts_nested_attributes_for :answer_validation, 
  	allow_destroy: true
  accepts_nested_attributes_for :choices, 
  	allow_destroy: true

  validates :label,
    uniqueness: true,
    label: true
  validates :description, presence: true
  validate :check_voices_and_validations

  def check_voices_and_validations
    if !has_choices_or_validation?
      errors.add(:choice, "must have either a choice or an answer validation")
      errors.add(:answer_validation, "must have either a choice or an answer validation")
    elsif has_choices_and_validation?
      errors.add(:choice, "can't have both a choice and an answer validation")
      errors.add(:answer_validation, "can't have both a choice and an answer validation")
    end
  end

  def has_choices_or_validation?
    !choices.empty? or !answer_validation.nil?
  end

  def has_choices_and_validation?
    !choices.empty? and !answer_validation.nil?
  end

  def check_answer(answer)
    if !self.answer_validation.nil?
      return (/#{self.answer_validation.regular_expression}/ =~ answer) == 0
    else
      return self.choices.any? { |choice| choice.text == answer }
    end
  end
end
