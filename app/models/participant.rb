class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :study

  has_one :schedule
  has_many :answer_sets, dependent: :destroy
  has_many :answers
  has_many :schedule_entries

  validates :user,
    presence: true,
    uniqueness: { scope: :study }

  after_create :create_schedule

  def create_schedule
    relevant_template = self.study.schedule_templates.first
    schedule = Schedule.new
    schedule.schedule_template = relevant_template
    schedule.start_time = self.created_at

    self.schedule = schedule
    self.save
    relevant_template.schedule_template_entries.each do |template_entry|
      time_to_take = schedule.start_time + template_entry.time_offset_hours.hours
      schedule_entry = ScheduleEntry.new
      schedule_entry.time_to_send = time_to_take
      schedule_entry.sent = false
      schedule_entry.participant = self
      schedule_entry.questionnaire = template_entry.questionnaire
      schedule_entry.schedule = schedule
      schedule_entry.save
    end
  end

  def next_schedule_entry
    upcoming_entries = self.schedule_entries.where('time_to_send < ?', DateTime.now).order(:time_to_send)
    upcoming_entries.each do |entry|
      if !entry.taken
        return entry
      end
    end
    nil
  end

  def questionnaires_taken
    self.answer_sets.length
  end

  def total_questionnaires
    self.schedule_entries.length
  end

  def study_length_in_days
    ordered_entries = self.schedule_entries.order(:time_to_send)
    seconds = (ordered_entries.last.time_to_send - self.created_at).to_i.abs
    (seconds / 3600 / 24).ceil
  end
end
