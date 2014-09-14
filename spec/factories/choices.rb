# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :choice do
    sequence(:label) { |n| "choice_#{n}" }
    sequence(:text) { |n| "#{n}" }
    sequence(:order) { |n| n }
    answer_type
  end
end
