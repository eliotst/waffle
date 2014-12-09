require 'spec_helper'

describe ScheduleTemplate do
  it "has a valid factory" do
    create(:schedule_template).should be_valid
  end
  it_behaves_like "a model with schedule template entries" do
    let(:model_factory) { :schedule_template_entries }
  end
end