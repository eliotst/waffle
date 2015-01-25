class BlockQuestionnaire < ActiveRecord::Base
  belongs_to :block
  belongs_to :questionnaire

  after_destroy :check_for_last

  def check_for_last
    if self.block.questionnaires.length == 0
      self.block.destroy
    end

    if self.questionnaire.blocks.length == 0
      self.questionnaire.destroy
    end
  end
end
