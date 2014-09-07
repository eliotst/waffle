class Participant < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :user,
    presence: true,
    uniqueness: true
end
