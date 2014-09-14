require 'spec_helper'

describe AnswerType do
  it "has a valid factory" do
    create(:answer_type).should be_valid
  end
  it_behaves_like "a model with a label" do
      let(:model_factory) { :answer_type }
  end
  describe "description" do
    it "should be present" do
      build(:answer_type, description: nil).should_not be_valid
    end
  end
end
