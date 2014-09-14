class AnswerValidation < ActiveRecord::Base
  belongs_to :answer_type

  validates :label,
    presence: true,
    length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9_]+\z/ },
    uniqueness: true

  validates :regular_expression,
    presence: true
end
