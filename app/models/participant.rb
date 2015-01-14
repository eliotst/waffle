class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :study

  has_many :answer_sets, dependent: :destroy
  has_many :answers
  has_many :schedule_entries

  validates :user,
    presence: true,
    uniqueness: { scope: :study }

  after_create :create_schedule

  def create_schedule
  end

  def next_questionnaire
    upcoming_entries = self.schedule_entries.where('time_to_send > ?', DateTime.now).order(:time_to_send)
    upcoming_entries.each do |entry|
      if entry.questionnaire.answer_sets.where(participant_id: self.id).length > 0
        return entry.questionnaire
      end
    end
    nil
  end
end
