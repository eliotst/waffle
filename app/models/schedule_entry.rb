class ScheduleEntry < ActiveRecord::Base
  belongs_to :participant
  belongs_to :schedule
  belongs_to :questionnaire

  validates :time_to_send, presence: true
  validates :participant, presence: true, uniqueness: true
  validates :schedule, presence: true

  self.per_page = 10
end
