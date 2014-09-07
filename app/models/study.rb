class Study < ActiveRecord::Base
  has_many :questionnaires, dependent: :destroy

  accepts_nested_attributes_for :questionnaires,
    reject_if: lambda { |a| a[:label].blank? },
    allow_destroy: true

  validates :title,
    presence: true,
    uniqueness: true

  self.per_page = 10
end
