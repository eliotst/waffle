require 'spec_helper'

describe ScheduleTemplate do
  it "has a valid factory" do
    create(:schedule_template).should be_valid
  end
  it "should be invalid without any entries" do
    schedule_template = build(:schedule_template)
    schedule_template.schedule_template_entries.clear()
    schedule_template.should_not be_valid
  end
end
