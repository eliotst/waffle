class Choice < ActiveRecord::Base
  belongs_to :question

  validates_presence_of :value

  self.per_page = 10
end
