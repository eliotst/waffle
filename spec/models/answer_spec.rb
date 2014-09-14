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
end
