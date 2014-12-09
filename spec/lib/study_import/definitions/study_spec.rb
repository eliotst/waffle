require 'spec_helper'

describe StudyImport::Definitions::Study, type: :request do
  before(:each) do
    @study = StudyImport::Definitions::Study.new
    @study.label = 'foo'
    @study.title = 'foo'
  end
  it "has a label attribute" do
    expect(@study.label).to eq('foo')
  end
  it "has a title attribute" do
    expect(@study.title).to eq('foo')
  end
  it "can capture the definition in a dictionary" do
    expect(@study.to_dictionary).to eq({
      label: @study.label,
      title: @study.title
    })
  end
  describe "create" do
    before(:each) do
      @study = StudyImport::Definitions::Study.new
      @study.label = "foo"
      @study.title = "The Study"
      @admin_user = create(:admin)
      post sessions_path, email: @admin_user.email, password: "secret"
      @study.create(self)
    end
    it "creates the block" do
      expect(Study.count).to eq(1)
    end
  end
end
