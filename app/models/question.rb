class Question < ActiveRecord::Base
  belongs_to :block
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers,
  	reject_if: lambda { |a| a[:value].blank? },
  	allow_destroy: true

  validates :label,
    presence: true,
    length: { maximum: 20 },
    format: { with: /\A[a-zA-Z0-9_]+\z/ },
    uniqueness: true
  validates :text,
    presence: true,
    format: { with: /[\?.]\z/ }

  self.per_page = 10
end
