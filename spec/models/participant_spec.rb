require 'spec_helper'

describe Participant do
  it "has a valid factory" do
    create(:participant).should be_valid
  end
  it "should be invalid without a user" do
    build(:participant, user: nil).should_not be_valid
  end
  it "should be unique for each user" do
    test_user = create(:user)
    create(:participant, user: test_user)
    build(:participant, user: test_user).should_not be_valid
  end
  describe "destroy" do
    it "destroys the participants' answers" do
      participant = create(:participant_with_answers)
      participant.destroy
      Answer.count.should == 0
    end
  end
end
