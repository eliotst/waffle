require 'spec_helper'

describe Question do
  it "has a valid factory" do
    create(:question).should be_valid
  end
  describe "the question text" do
    it "should be invalid if empty" do
      build(:question, text: nil).should_not be_valid
    end
    it "should be invalid without an answer type" do
      build(:question, answer_type: nil).should_not be_valid
    end
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :question }
  end
end
