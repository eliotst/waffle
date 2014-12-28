require 'spec_helper'

describe StudyImport::Definitions::ScheduleTemplate do
  before(:each) do
    @study = create(:study)
    @questionnaire = create(:questionnaire)
    @schedule_template = StudyImport::Definitions::ScheduleTemplate.new
    @schedule_template_entry = StudyImport::Definitions::ScheduleTemplateEntry.new
    @schedule_template_entry.questionnaire_label = @questionnaire.label
    @schedule_template_entry.time_offset_hours = 4
    @schedule_template.entries.append(@schedule_template_entry)
    @schedule_template.study_label = @study.label
  end
  it "has an entries attribute" do
    schedule_template = StudyImport::Definitions::ScheduleTemplate.new
    expect(schedule_template.entries.length).to eq(0)
  end
  describe "to_dictionary" do
    it "can capture the definition in a dictionary" do
        expect(@schedule_template.to_dictionary).to eq({
          study_id: @study.id,
          schedule_template_entries_attributes: {
            0 => {
              questionnaire_id: @questionnaire.id,
              time_offset_hours: 4
            }
          }
        })
    end
  end
  describe "create", type: :request do
    before(:each) do
      @admin_user = create(:admin)
      post sessions_path, email: @admin_user.email, password: "secret"

      @schedule_template.create(self)
    end
    it "creates the schedule template" do
      expect(ScheduleTemplate.count).to eq(1)
    end
    it "creates the schedule template correctly" do
      created_template = ScheduleTemplate.first
      created_template.study_id = @study.id
    end
    describe "the schedule template entry" do
      it "creates it" do
        expect(ScheduleTemplateEntry.count).to eq(1)
      end
      it "creates it correctly" do
        created_entry = ScheduleTemplateEntry.first
        expect(created_entry.time_offset_hours).to eq(4)
        expect(created_entry.questionnaire_id).to eq(@questionnaire.id)
      end
    end
  end
end
