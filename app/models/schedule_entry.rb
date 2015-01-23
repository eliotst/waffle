class ScheduleEntry < ActiveRecord::Base
  belongs_to :participant
  belongs_to :schedule
  belongs_to :questionnaire

  has_many :answer_sets

  validates :time_to_send, presence: true, uniqueness: { scope: :participant }
  validates :participant, presence: true
  validates :schedule, presence: true

  self.per_page = 10

  def taken
    self.answer_sets.length > 0
  end
end
