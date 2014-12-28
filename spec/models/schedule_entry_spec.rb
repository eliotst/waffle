require 'spec_helper'

describe ScheduleEntry do
  it "has a valid factory" do
    create(:schedule_entry).should be_valid
  end
  it "should not be valid without a time to send" do
    build(:schedule_entry, time_to_send: nil).should_not be_valid
  end
  it "should not be valid without a participant" do
    build(:schedule_entry, participant: nil).should_not be_valid
  end
  it "should not be valid without a schedule" do
    build(:schedule_entry, schedule: nil).should_not be_valid
  end
end
