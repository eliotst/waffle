require 'spec_helper'

describe Block do
  it "has a valid factory" do
    create(:block).should be_valid
  end
  it "should be invalid without a label" do
    build(:block, label: nil).should_not be_valid
  end
end
