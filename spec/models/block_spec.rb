require 'spec_helper'

describe Block do
  it "has a valid factory" do
    create(:block).should be_valid
  end
  it "orders the questions correctly" do
    @question_three = create(:question, number: 3)
    @question_one = create(:question, number: 1)
    @question_two = create(:question, number: 2)
    @block = create(:block)
    @block.questions.push(@question_three)
    @block.questions.push(@question_one)
    @block.questions.push(@question_two)

    current = 1
    @block.questions.each do |question|
      question.number.should eq(current)
      current += 1
    end
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :block }
  end
  describe "destroy" do
    it "destroys the block questionnaires" do
      block = create(:block_with_questionnaire)
      block.destroy
      BlockQuestionnaire.count.should == 0
    end
  end
end
