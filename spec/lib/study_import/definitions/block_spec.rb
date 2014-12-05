require 'spec_helper'

describe StudyImport::Definitions::Block do
  before(:each) do
    @block = StudyImport::Definitions::Block.new
    @block.label = 'foo'
  end
  it "has a label attribute" do
    expect(@block.label).to eq('foo')
  end
  it "can capture the definition in a dictionary" do
    expect(@block.to_dictionary).to eq({
      label: 'foo'
    })
  end
  describe "create", type: :request do
    before(:each) do
      @block = StudyImport::Definitions::Block.new
      @block.label = "foo"
      @admin_user = create(:admin)
      post sessions_path, email: @admin_user.email, password: "secret"
      @block.create(self)
    end
    it "creates the block" do
      expect(Block.count).to eq(1)
    end
  end
end
