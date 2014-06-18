require 'spec_helper'

describe Question do
  it "creates a question" do
    question = Question.create(text: "Words words words?",
     label: "word")
  end
  it "has a valid factory" do
    create(:question).should be_valid
  end
  it "is invalid with a space in the label" do
    build(:question, label: "bad label").should_not be_valid
  end
  it "is invalid with a symbol in the label" do
    build(:question, label: "bad_label%").should_not be_valid
  end
  it "is invalid with more than 20 characters in the label" do
    build(:question, label: "abcdefghijklmnopqrstu").should_not be_valid
  end
  it "is invalid when the text doesn't end in a '?'" do
    build(:question, text: "This isn't a question.").should_not be_valid
  end
  it "is valid when the text does end in a '?'" do
    build(:question, text: "This is a question?").should be_valid
  end
end


