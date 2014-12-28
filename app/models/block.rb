class Block < ActiveRecord::Base
  has_many :block_questionnaires, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :questionnaires, through: :block_questionnaires

  validates :label,
    uniqueness: true,
    label: true

  self.per_page = 10
end
