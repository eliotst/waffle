require 'spec_helper'

describe ScheduleTemplateEntry do
  it "has a valid factory" do
    create(:schedule_template_entry).should be_valid
  end
  describe "#time_offset_hours" do
    it "should be invalid without any" do
      build(:schedule_template_entry, time_offset_hours: nil).should_not be_valid
    end
    it "should be invalid if hours are negative" do
      build(:schedule_template_entry, time_offset_hours: -5).should_not be_valid
    end
  end
  it "should be invalid without a questionnaire" do
    build(:schedule_template_entry, questionnaire: nil).should_not be_valid
  end
  it "should be invalid without a template" do
    build(:schedule_template_entry, schedule_template: nil).should_not be_valid
  end
end
