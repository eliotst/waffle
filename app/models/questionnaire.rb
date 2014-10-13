class Questionnaire < ActiveRecord::Base
  has_many :blocks, dependent: :destroy
  belongs_to :study

  validates :label,
    presence: true,
    length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9_]+\z/ },
    uniqueness: true

  self.per_page = 10
end
