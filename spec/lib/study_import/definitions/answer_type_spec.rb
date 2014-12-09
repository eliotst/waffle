require 'spec_helper'

describe StudyImport::Definitions::AnswerType do
  it "has a label attribute" do
    answer_type = StudyImport::Definitions::AnswerType.new
    answer_type.label = 'foo'
    expect(answer_type.label).to eq('foo')
  end
  it "has a description attribute" do
    answer_type = StudyImport::Definitions::AnswerType.new
    answer_type.description = 'foo'
    expect(answer_type.description).to eq('foo')
  end
  it "has a regular_expression attribute" do
    answer_type = StudyImport::Definitions::AnswerType.new
    answer_type.regular_expression = /\w+/
    expect(answer_type.regular_expression).to eq(/\w+/)
  end
  it "has a choices attribute" do
    answer_type = StudyImport::Definitions::AnswerType.new
    answer_type.choices.append(1)
    expect(answer_type.choices).to eq([1])
  end
  describe "to_dictionary" do
    before(:each) do
      @answer_type = StudyImport::Definitions::AnswerType.new
      @answer_type.label = 'foo'
      @answer_type.description = 'foo'
    end
    context "with choices" do
      it "can capture the definition in a dictionary" do
        choice = StudyImport::Definitions::Choice.new
        choice.value = 'bar'
        choice.text = 'bar'
        choice.order = 1
        @answer_type.choices.append(choice)
        expect(@answer_type.to_dictionary).to eq({
          label: 'foo',
          description: 'foo',
          choices_attributes: [
            {
              value: 'bar',
              text: 'bar',
              order: 1
            }
          ]
        })
      end
    end
    context "with answer validations" do
      it "can capture the definition in a dictionary" do
        @answer_type.regular_expression = /\w+/
        expect(@answer_type.to_dictionary).to eq({
          label: 'foo',
          description: 'foo',
          answer_validation_attributes: {
            regular_expression: /\w+/
          }
        })
      end
    end
  end
  describe "create", type: :request do
    before(:each) do
      @answer_type = StudyImport::Definitions::AnswerType.new
      @answer_type.label = 'foo'
      @answer_type.description = 'foo things'
      @admin_user = create(:admin)
      post sessions_path, email: @admin_user.email, password: "secret"
    end
    context "with choices" do
      before(:each) do
        choice = StudyImport::Definitions::Choice.new
        choice.value = 'bar'
        choice.text = 'bar'
        choice.order = 1
        @answer_type.choices.append(choice)
        @answer_type.create(self)
      end
      it "creates the answer type" do
        expect(AnswerType.count).to eq(1)
      end
      it "creates the choice" do
        expect(Choice.count).to eq(1)
      end
    end
  end
end
