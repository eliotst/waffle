require 'spec_helper'

describe Block do
  it "has a valid factory" do
    create(:block).should be_valid
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :block }
  end
end
