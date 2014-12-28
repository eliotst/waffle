FactoryGirl.define do
  factory :question do
    sequence(:label) { |n| "question_#{n}" }
    text "To be or not to be?"
    block
    answer_type { create(:number_validation_answer_type) }

    factory :question_with_answers do
      after(:build) do |question|
        question.answers << create(:answer, question: question)
      end
    end
  end
end
