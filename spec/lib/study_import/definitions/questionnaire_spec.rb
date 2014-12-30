require 'spec_helper'

describe StudyImport::Definitions::Questionnaire do
  before(:each) do
    @questionnaire = StudyImport::Definitions::Questionnaire.new
    @questionnaire.label = 'foo'
    @questionnaire.study_label = 'foo'
    @questionnaire.blocks = []
    @study = create(:study, label: @questionnaire.study_label)
  end
  it "has a label attribute" do
    expect(@questionnaire.label).to eq('foo')
  end
  it "has a study_label attribute" do
    expect(@questionnaire.study_label).to eq('foo')
  end
  it "has a study_id attribute" do
    expect(@questionnaire.study_id).to eq(@study.id)
  end
  it "has a blocks attribute" do
    expect(@questionnaire.blocks).to eq([])
  end
  it "can capture the definition in a dictionary" do
    expect(@questionnaire.to_dictionary).to eq({
      label: @questionnaire.label,
      study_id: @study.id
    })
  end
  describe "create", type: :request do
    before(:each) do
      @study = create(:study, label: "foo_study")
      @block = create(:block, label: "foo_block")
      @questionnaire = StudyImport::Definitions::Questionnaire.new
      @questionnaire.label = "foo"
      @questionnaire.study_label = "foo_study"
      @questionnaire.blocks = ["foo_block"]
      @admin_user = create(:admin)
      post sessions_path, email: @admin_user.email, password: "secret"
      @questionnaire.create(self)
    end
    it "creates the questionnaire" do
      expect(Questionnaire.count).to eq(1)
    end
    it "attaches the questionnaire to thee study" do
      expect(Questionnaire.first.study).to eq(@study)
    end
    it "creates thee blocks" do
      expect(Questionnaire.first.blocks.length).to eq(1)
      expect(Questionnaire.first.blocks.first).to eq(@block)
    end
  end
end
