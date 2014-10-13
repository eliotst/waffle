class AnswerValidation < ActiveRecord::Base
  belongs_to :answer_type

  validates :regular_expression,
    presence: true
end
