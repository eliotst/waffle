# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer_type do
    sequence(:label) { |n| "answer_type_#{n}" }
    study
    description "Answer Type Description"
    after(:build) do |answer_type|
      answer_type.answer_validation = build(:answer_validation, answer_type: answer_type)
    end
    factory :number_validation_answer_type do
      after(:build) do |answer_type|
        answer_type.answer_validation = build(:number_validation, answer_type: answer_type)
      end
    end
    factory :true_false_choice_answer_type do
      after(:build) do |answer_type|
        answer_type.answer_validation.answer_type = nil
        answer_type.answer_validation = nil
        answer_type.choices << create(:true_choice, answer_type: answer_type)
        answer_type.choices << create(:false_choice, answer_type: answer_type)
      end
    end
  end
end
