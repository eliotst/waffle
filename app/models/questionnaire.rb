class Questionnaire < ActiveRecord::Base
  belongs_to :study

  has_many :block_questionnaires, dependent: :destroy
  has_many :blocks, through: :block_questionnaires
  has_many :answer_sets, dependent: :destroy

  validates :label,
    uniqueness: true,
    label: true

  self.per_page = 10

  def create_answer_set
    answer_set = AnswerSet.new
    self.blocks.each do |block|
      block.questions.each do |question|
        answer = Answer.new
        answer.question = question
        answer_set.answers.push(answer)
      end
    end
    answer_set.questionnaire = self
    answer_set
  end
end
