class Block < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  belongs_to :questionnaire

  accepts_nested_attributes_for :questions, 
  	reject_if: lambda { |a| a[:text].blank? },
  	allow_destroy: true

  validates :label,
    presence: true,
    length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9_]+\z/ },
    uniqueness: true

  self.per_page = 10
end
