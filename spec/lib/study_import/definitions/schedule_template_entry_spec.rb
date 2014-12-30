require 'spec_helper'

describe StudyImport::Definitions::ScheduleTemplateEntry do
  it "has a questionnaire_label attribute" do
    schedule_template_entry = StudyImport::Definitions::ScheduleTemplateEntry.new
    schedule_template_entry.questionnaire_label = 'foo'
    expect(schedule_template_entry.questionnaire_label).to eq('foo')
  end
  it "has a time_offset_hours attribute" do
    schedule_template_entry = StudyImport::Definitions::ScheduleTemplateEntry.new
    schedule_template_entry.time_offset_hours = 2
    expect(schedule_template_entry.time_offset_hours).to eq(2)
  end
  describe "to_dictionary" do
    before(:each) do
      @questionnaire = create(:questionnaire)
      @schedule_template_entry = StudyImport::Definitions::ScheduleTemplateEntry.new
      @schedule_template_entry.questionnaire_label = @questionnaire.label
      @schedule_template_entry.time_offset_hours = 4
    end
    it "can capture the definition in a dictionary" do
        expect(@schedule_template_entry.to_dictionary).to eq({
          questionnaire_id: @questionnaire.id,
          time_offset_hours: 4
        })
    end
  end
end
