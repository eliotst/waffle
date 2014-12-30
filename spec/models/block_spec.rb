require 'spec_helper'

describe Block do
  it "has a valid factory" do
    create(:block).should be_valid
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :block }
  end
  describe "destroy" do
    it "destroys the block questionnaires" do
      block = create(:block_with_questionnaire)
      block.destroy
      BlockQuestionnaire.count.should == 0
    end
  end
end
