# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer_type do
    sequence(:label) { |n| "answer_type_#{n}" }
    description "Answer Type Description"
  end
end
