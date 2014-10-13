class Study < ActiveRecord::Base
  has_many :questionnaires, dependent: :destroy

  validates :title,
    presence: true,
    uniqueness: true
  validates :label,
    presence: true,
    length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9_]+\z/ },
    uniqueness: true

  self.per_page = 10
end
