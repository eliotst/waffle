require 'spec_helper'

describe StudyImport::Definitions::Question do
  before(:each) do
    @question = StudyImport::Definitions::Question.new
    @question.label = 'foo'
    @question.text = 'foo?'
    @question.answer_type_label = 'foo'
    @question.block_label = 'foo'
    @question.number = 1
    @answer_type = create(:answer_type, label: @question.answer_type_label)
    @block = create(:block, label: @question.block_label)
  end
  it "has a label attribute" do
    expect(@question.label).to eq('foo')
  end
  it "has a text attribute" do
    expect(@question.text).to eq('foo?')
  end
  it "has a answer_type_label attribute" do
    expect(@question.answer_type_label).to eq('foo')
  end
  it "has a answer_type_id attribute" do
    expect(@question.answer_type_id).to eq(@answer_type.id)
  end
  it "has a block_label attribute" do
    expect(@question.block_label).to eq('foo')
  end
  it "has a block_id attribute" do
    expect(@question.block_id).to eq(@block.id)
  end
  it "can capture the definition in a dictionary" do
    expect(@question.to_dictionary).to eq({
      label: @question.label,
      answer_type_id: @answer_type.id,
      block_id: @block.id,
      number: @question.number,
      text: @question.text
    })
  end
  describe "create", type: :request do
    before(:each) do
      @block = create(:block, label: "foo_block")
      @answer_type = create(:answer_type, label: "foo_answer_type")
      @admin_user = create(:admin)
      post sessions_path, email: @admin_user.email, password: "secret"
      @question = StudyImport::Definitions::Question.new
      @question.label = "foo"
      @question.text = "What the foo?"
      @question.number = 1
      @question.block_label = "foo_block"
      @question.answer_type_label = "foo_answer_type"
      @question.create(self)
    end
    it "creates the block" do
      expect(Question.count).to eq(1)
    end
    it "hooks the question to the block" do
      expect(Question.first.block).to eq(@block)
    end
    it "hooks the question to the answer type" do
      expect(Question.first.answer_type).to eq(@answer_type)
    end
  end
end
