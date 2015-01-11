class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :study

  has_many :answer_sets, dependent: :destroy
  has_many :answers

  validates :user,
    presence: true,
    uniqueness: true
end
