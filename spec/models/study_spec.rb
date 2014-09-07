require 'spec_helper'

describe Study do
  it "has a valid factory" do
    create(:study).should be_valid
  end
  it "should be invalid without any title" do
    build(:study, title: nil).should_not be_valid
  end
  it "should be invalid without a unique title" do
    create(:study, title: 'Study')
    build(:study, title: 'Study').should_not be_valid
  end
end
