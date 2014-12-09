require 'spec_helper'

describe StudyImport::Definitions::Choice do
  it "has a value attribute" do
    choice = StudyImport::Definitions::Choice.new
    choice.value = 'foo'
    expect(choice.value).to eq('foo')
  end
  it "has a text attribute" do
    choice = StudyImport::Definitions::Choice.new
    choice.text = 'foo?'
    expect(choice.text).to eq('foo?')
  end
  it "has a order attribute" do
    choice = StudyImport::Definitions::Choice.new
    choice.order = 1
    expect(choice.order).to eq(1)
  end
  describe "#to_dictionary" do
    it "can capture the definition in a dictionary" do
      choice = StudyImport::Definitions::Choice.new
      choice.order = 1
      choice.text = 'foo?'
      choice.value = 'foo'
      expect(choice.to_dictionary).to eq({ value: 'foo', text: 'foo?', order: 1 })
    end
  end
end
