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
  it "can not have both an answer validation and a choice" do
    answer_type = build(:answer_type)
    answer_type.answer_validation = build(:answer_validation, answer_type: answer_type)
    answer_type.choices.append(build(:choice, answer_type: answer_type))
    answer_type.should_not be_valid
  end
  it "should have an answer validation or a choice" do
    answer_type = build(:answer_type)
    answer_type.answer_validation = nil
    answer_type.should_not be_valid
  end
end
