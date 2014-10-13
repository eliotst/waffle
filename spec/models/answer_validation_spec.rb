require 'spec_helper'

describe AnswerValidation do
  it "has a valid factory" do
    create(:answer_validation).should be_valid
  end
  describe "regular_expression" do
    it "should be present" do
      build(:answer_validation, regular_expression: nil).should_not be_valid
    end
  end
end
