require File.dirname(__FILE__) + '/../spec_helper'

describe Block do
  it "should be valid" do
    Block.new.should be_valid
  end
end
