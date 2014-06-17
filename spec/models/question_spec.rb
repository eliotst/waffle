require 'spec_helper'

describe Question do
  it "creates a question" do
    question = Question.create(text: "Words words words?",
     label: "word")
  end
  it "has a valid factory" do
    FactoryGirl.create(:question).should be_valid
  end
  it "is invalid with a space in the label" do
    FactoryGirl.build(:question, label: "bad label").should_not be_valid
  end
  it "is invalid with a symbol in the label" do
    FactoryGirl.build(:question, label: "bad_label%").should_not be_valid
  end
  it "is invalid with more than 20 characters in the label" do
    FactoryGirl.build(:question, label: "abcdefghijklmnopqrstu").should_not be_valid
  end
end


