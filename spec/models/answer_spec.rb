require 'spec_helper'

describe Answer do
  it "has a valid factory" do
    create(:answer).should be_valid
  end
  it "should be invalid without a question" do
    build(:answer, question: nil).should_not be_valid
  end
  it "should be invalid without a value" do
    build(:answer, value: nil).should_not be_valid
  end
  it "should be invalid without a participant" do
    build(:answer, participant: nil).should_not be_valid
  end
  describe "with a choice answer type" do
    before(:each) do
      @question = create(:question, answer_type: create(:true_false_choice_answer_type))
    end
    it "should not be valid if the answer is not one of the choices" do
      build(:answer, value: "foo", question: @question).should_not be_valid
    end
    it "should be valid if the answer is one of the choices" do
      build(:answer, value: "true", question: @question).should be_valid
    end
  end
  describe "with a answer validation answer type" do
    before(:each) do
      @question = create(:question, answer_type: create(:number_validation_answer_type ))
    end
    it "should not be valid if the answer does not match the validation" do
      build(:answer, value: "foo", question: @question).should_not be_valid
    end
    it "should be valid if the answer does match the validation" do
      build(:answer, value: "1", question: @question).should be_valid
    end
  end
end
