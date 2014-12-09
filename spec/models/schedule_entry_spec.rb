require 'spec_helper'

describe ScheduleEntry do
  it "has a valid factory" do
    create(:schedule_entry).should be_valid
  end
  it_behaves_like "a model with a time to send" do
    let(:model_factory) { :time_to_send }
  end
  it_behaves_like "a model with a participant" do
    let(:model_factory) { :participant }
  end
  it_behaves_like "a model with a schedule template" do
    let(:model_factory) { :schedule_template }
  end
end
