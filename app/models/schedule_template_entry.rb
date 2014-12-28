class ScheduleTemplateEntry < ActiveRecord::Base
  belongs_to :schedule_template, inverse_of: :schedule_template_entries
  belongs_to :questionnaire

  validates :time_offset_hours, presence: true, numericality: {:greater_than => 0}
  validates :questionnaire, presence: true
  validates :schedule_template, presence: true

  self.per_page = 10
end


