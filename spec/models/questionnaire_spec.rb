require 'spec_helper'

describe Questionnaire do
  it "has a valid factory" do
    create(:questionnaire).should be_valid
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :questionnaire }
  end
end

