class Study < ActiveRecord::Base
  has_many :questionnaires, dependent: :destroy

  validates :title,
    presence: true,
    uniqueness: true
  validates :label,
    uniqueness: true,
    label: true

  self.per_page = 10
end
