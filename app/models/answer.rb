class Answer < ActiveRecord::Base
  belongs_to :participant
  belongs_to :question
  before_save { @participant = self.participant }

  validates_presence_of :participant

  self.per_page = 10
end
