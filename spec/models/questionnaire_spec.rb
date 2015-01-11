require 'spec_helper'

describe Questionnaire do
  it "has a valid factory" do
    create(:questionnaire).should be_valid
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :questionnaire }
  end
  describe "create_answer_set" do
    before(:each) do
      @questionnaire = create(:questionnaire_with_blocks)
    end
    it "creates an answer set" do
      @questionnaire.create_answer_set().should_not be_nil
    end
    it "creates an answer set with the right questions" do
      questionnaire_questions = []
      @questionnaire.blocks.each do |block|
        block.questions.each do |question|
          questions.push(question)
        end
      end
      answer_set = @questionnaire.create_answer_set()
      questionnaire_questions.length.should eq(answer_set.answers.length)
      answer_set.answers.each do |answer|
        questionnaire_questions.should include(answer.question)
      end
    end
  end
  describe "destroy" do
    it "destroys the block questionnaires" do
      questionnaire = create(:questionnaire_with_blocks)
      questionnaire.destroy
      BlockQuestionnaire.count.should == 0
    end
  end
end

