class Answer < ActiveRecord::Base
  belongs_to :participant
  belongs_to :question

  validates :participant,
    presence: true
  validates :value,
    presence: true
  validates :question,
    presence: true

  self.per_page = 10
end
