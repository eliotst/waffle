class Questionnaire < ActiveRecord::Base
  has_many :block_questionnaires, dependent: :destroy
  has_many :blocks, through: :block_questionnaires
  belongs_to :study

  validates :label,
    uniqueness: true,
    label: true

  self.per_page = 10
end
