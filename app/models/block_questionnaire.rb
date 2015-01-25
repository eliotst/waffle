class BlockQuestionnaire < ActiveRecord::Base
  belongs_to :block
  belongs_to :questionnaire

  # after_destroy :check_for_last

  def check_for_last
    if self.block.questionnaires.length == 0 and not self.block.destroyed?
      self.block.destroy
    end

    if self.questionnaire.blocks.length == 0 and not self.questionnaire.destroyed?
      self.questionnaire.destroy
    end
  end
end
