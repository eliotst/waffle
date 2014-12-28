require 'spec_helper'

describe Questionnaire do
  it "has a valid factory" do
    create(:questionnaire).should be_valid
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :questionnaire }
  end
  describe "destroy" do
    it "destroys the block questionnaires" do
      questionnaire = create(:questionnaire_with_blocks)
      questionnaire.destroy
      BlockQuestionnaire.count.should == 0
    end
  end
end

