class AnswerType < ActiveRecord::Base
  validates :label,
    presence: true,
    length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9_]+\z/ },
    uniqueness: true

  validates :description, presence: true
end
