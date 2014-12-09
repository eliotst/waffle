require 'spec_helper'

describe ScheduleTemplateEntry do
  it "has a valid factory" do
    create(:schedule_template_entry).should be_valid
  end
  it_behaves_like "a model with a time of offset hours" do
    let(:model_factory) { :time_offset_hours }
  end
  it_behaves_like "a model with a questionnaire" do
    let(:model_factory) { :questionnaire }
  end
  it_behaves_like "a model with a schedule template" do
    let(:model_factory) { :schedule_template }
  end
end
