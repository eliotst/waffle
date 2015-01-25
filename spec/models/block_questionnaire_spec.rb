require 'spec_helper'

describe BlockQuestionnaire do
  describe "destroying" do
    before(:each) do
      @block_questionnaire = create(:block_questionnaire)
    end
    it "deletes the block if it doesn't have any more questionnaires" do
      @block_questionnaire.destroy
      Block.count.should == 0
    end
    it "deletes the questionnaire if it doesn't have any more blocks" do
      @block_questionnaire.destroy
      Questionnaire.count.should == 0
    end
    it "doesn't delete a questionnaire with more blocks" do
      @block_questionnaire.questionnaire.blocks.append(create(:block))
      @block_questionnaire.destroy
      Questionnaire.count.should == 1
    end
    it "doesn't delete a block with more questionnaires" do
      @block_questionnaire.block.questionnaires.append(create(:questionnaire))
      @block_questionnaire.destroy
      Block.count.should == 1
    end
  end
end
