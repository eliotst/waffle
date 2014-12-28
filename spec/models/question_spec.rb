require 'spec_helper'

describe Question do
  it "has a valid factory" do
    create(:question).should be_valid
  end
  it "should be invalid without text" do
    build(:question, text: nil).should_not be_valid
  end
  it "should be invalid without an answer type" do
    build(:question, answer_type: nil).should_not be_valid
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :question }
  end
  describe "destroy" do
    it "should destroy the answers" do
      question = create(:question_with_answers)
      question.destroy
      Answer.count.should == 0
    end
  end
end
