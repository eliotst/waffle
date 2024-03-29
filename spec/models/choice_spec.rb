require 'spec_helper'

describe Choice do
  it "has a valid factory" do
    create(:choice).should be_valid
  end
  describe "#value" do
    it "should be present" do
      build(:choice, value: nil).should_not be_valid
    end
    it "should be unique for the answer type" do
      answer_type = create(:answer_type)
      create(:choice, value: "foo", answer_type: answer_type)
      build(:choice, value: "foo", answer_type: answer_type).should_not be_valid
    end
  end
  describe "#text" do
    it "should be present" do
      build(:choice, text: nil).should_not be_valid
    end
    it "should be unique for the answer type" do
      answer_type = create(:answer_type)
      create(:choice, text: "foo", answer_type: answer_type)
      build(:choice, text: "foo", answer_type: answer_type).should_not be_valid
    end
  end
  describe "#order" do
    it "should be present" do
      build(:choice, order: nil).should_not be_valid
    end
    it "should be unique for the answer type" do
      answer_type = create(:answer_type)
      create(:choice, order: 1, answer_type: answer_type)
      build(:choice, order: 1, answer_type: answer_type).should_not be_valid
    end
  end
end
