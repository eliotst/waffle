class Schedule < ActiveRecord::Base
  belongs_to :schedule_template
  belongs_to :participant

  has_many :schedule_entries, dependent: :destroy

  validates :start_time, presence: true
  validates :participant, presence: true
  validates :schedule_template, presence: true

  self.per_page = 10
end
