# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer_validation do
    sequence(:label) { |n| "answer_validation_#{n}" }
    regular_expression "."
    answer_type
  end
end
