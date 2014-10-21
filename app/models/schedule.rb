class Schedule < ActiveRecord::Base
  belongs_to :schedule_template
  belongs_to :participant

  validates :start_time_epoch_seconds, presence: true
  validates :participant, presence: true, uniqueness: true
  validates :schedule_template, presence: true

  self.per_page = 10
end
