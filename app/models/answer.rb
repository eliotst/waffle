class Answer < ActiveRecord::Base
  belongs_to :participant
  belongs_to :question

  validates_presence_of :value
  validates_presence_of :participant

  self.per_page = 10
end
