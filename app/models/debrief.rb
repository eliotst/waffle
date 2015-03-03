class Debrief < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :choice, presence: true, blank: false
  validates :student_name, presence: true
  validates :instructor, presence: true
end
