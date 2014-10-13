class Questionnaire < ActiveRecord::Base
  has_many :blocks, dependent: :destroy
  belongs_to :study

  validates :label,
    uniqueness: true,
    label: true

  self.per_page = 10
end
