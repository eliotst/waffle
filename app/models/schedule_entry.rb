class ScheduleEntry < ActiveRecord::Base
  belongs_to :participant
  belongs_to :schedule_template
  belongs_to :questionnaire

  validates :time_to_send, presence: true
  validates :participant, presence: true, uniqueness: true
  validates :schedule_template, presence: true

  self.per_page = 10
end
