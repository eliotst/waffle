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
  it "has a study_label attribute" do
    answer_type = StudyImport::Definitions::AnswerType.new
    answer_type.study_label = "foo"
    expect(answer_type.study_label).to eq("foo")
  end
  it "has an allow multiple attribute" do
    answer_type = StudyImport::Definitions::AnswerType.new
    answer_type.allow_multiple = true
    expect(answer_type.allow_multiple).to eq(true)
  end
  describe "to_dictionary" do
    before(:each) do
      @study = create(:study)
      @answer_type = StudyImport::Definitions::AnswerType.new
      @answer_type.label = 'foo'
      @answer_type.description = 'foo'
      @answer_type.allow_multiple = true
      @answer_type.study_label = @study.label
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
          allow_multiple: true,
          study_id: @study.id,
          choices_attributes: {
            0 => {
              value: 'bar',
              text: 'bar',
              order: 1
            }
          }
        })
      end
    end
    context "with answer validations" do
      it "can capture the definition in a dictionary" do
        @answer_type.regular_expression = /\w+/
        expect(@answer_type.to_dictionary).to eq({
          label: 'foo',
          description: 'foo',
          study_id: @study.id,
          answer_validation_attributes: {
            regular_expression: /\w+/
          }
        })
      end
    end
  end
  describe "create", type: :request do
    before(:each) do
      @study = create(:study)
      @answer_type = StudyImport::Definitions::AnswerType.new
      @answer_type.label = 'foo'
      @answer_type.description = 'foo things'
      @answer_type.study_label = @study.label
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
