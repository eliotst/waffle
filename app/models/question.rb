class Question < ActiveRecord::Base
  belongs_to :block
  belongs_to :answer_type
  has_many :answers, dependent: :destroy

  validates :label,
    uniqueness: true,
    label: true
  validates :text,
    presence: true
  validates :number,
    presence: true,
    uniqueness: { scope: :block }
  validates :answer_type,
    presence: true

  self.per_page = 10

  def check_answer(answer)
    return answer_type.check_answer(answer)
  end
end
