class ScheduleTemplate < ActiveRecord::Base
  belongs_to :study

  has_many :schedule_template_entries, inverse_of: :schedule_template,
    dependent: :destroy
  has_many :schedules, dependent: :destroy

  validates :schedule_template_entries,
    presence: true

  validates :study,
    presence: true

  accepts_nested_attributes_for :schedule_template_entries, 
  	allow_destroy: true

  self.per_page = 10
end
