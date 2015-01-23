require 'spec_helper'

describe AnswerSet do
  it "has a valid factory" do
    create(:answer_set).should be_valid
  end
  it "is invalid without a questionnaire" do
    build(:answer_set, questionnaire: nil).should_not be_valid
  end
  it "is invalid without a participant" do
    build(:answer_set, participant: nil).should_not be_valid
  end
  it "is invalid without a schedule_entry" do
    build(:answer_set, schedule_entry: nil).should_not be_valid
  end

  describe "destroy" do
    it "destroys the answers" do
      answer_set = create(:answer_set_with_answers)
      answer_set.destroy
      Answer.count.should == 0
    end
  end
end
