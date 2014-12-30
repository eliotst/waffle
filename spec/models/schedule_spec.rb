require 'spec_helper'

describe Schedule do
  it "has a valid factory" do
    create(:schedule).should be_valid
  end
  it "should not be valid without a start time" do
    build(:schedule, start_time: nil).should_not be_valid
  end
  it "should not be valid without a participant" do
    build(:schedule, participant: nil).should_not be_valid
  end
  it "should not be valid without a schedule template" do
    build(:schedule, schedule_template: nil).should_not be_valid
  end
end
