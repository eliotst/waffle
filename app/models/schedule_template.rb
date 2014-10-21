class ScheduleTemplate < ActiveRecord::Base
  belongs_to :study_id

  has_many :schedule_template_entries
  has_many :schedules

  validates :schedule_template_entries, presence: true

  self.per_page = 10
end
