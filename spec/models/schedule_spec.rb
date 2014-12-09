require 'spec_helper'

describe Schedule do
  it "has a valid factory" do
    create(:schedule).should be_valid
  end
  it_behaves_like "a model with a start time in epoch seconds" do
    let(:model_factory) { :start_time_epoch_seconds }
  end
  it_behaves_like "a model with a participant" do
    let(:model_factory) { :participant }
  end
  it_behaves_like "a model with a schedule template" do
    let(:model_factory) { :schedule_template }
  end
end
