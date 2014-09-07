require 'spec_helper'

describe Questionnaire do
  it "has a valid factory" do
    create(:questionnaire).should be_valid
  end
  describe "the label" do
    it "should be invalid with a label that is too long" do
      build(:question, label: "123456789012345678901").should_not be_valid
    end
    it "should be invalid if the label has spaces" do
      build(:question, label: "invalid label").should_not be_valid
    end
    it "should be invalid if it is not alphanumeric only" do
      build(:question, label: "invalid!").should_not be_valid
    end
    it "should be invalid if not unique" do
      create(:question, label: "foo")
      build(:question, label: "foo").should_not be_valid
    end
  end
end

