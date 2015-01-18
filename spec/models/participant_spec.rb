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
    study = create(:study_with_schedule_templates)
    create(:participant, user: test_user, study: study)
    build(:participant, user: test_user, study: study).should_not be_valid
  end
  describe "create" do
    before(:each) do
      @study = create(:study_with_schedule_templates)
      @additional_template_entry = create(:schedule_template_entry,
                                          time_offset_hours: 5,
                                          schedule_template: @study.schedule_templates.first)
      @participant = create(:participant, study: @study)
    end
    it "should create a schedule" do
      @participant.schedule.should_not be_nil
    end
    it "should create two schedule entries" do
      ScheduleEntry.count.should == 2
    end
  end
  describe "destroy" do
    it "destroys the participants' answers" do
      participant = create(:participant_with_answers)
      participant.destroy
      Answer.count.should == 0
    end
  end
end
