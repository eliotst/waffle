require 'spec_helper'

describe Answer do
it "creates an answer" do
    question = Question.create(text: "Words words words?",
     label: "word")
    answer = Answer.create(value: "answer")
  end
  it "has a valid factory" do
    create(:answer).should be_valid
  end
  it "is invalid without something in the value" do
    build(:question, value: nil).should_not be_valid
  end
end
