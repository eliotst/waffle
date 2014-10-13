# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :choice do
    sequence(:value) { |n| "choice #{n}" }
    sequence(:text) { |n| "#{n}" }
    sequence(:order) { |n| n }
    answer_type
    factory :true_choice do
      value { "true" }
      text { "true" }
      order { 1 }
    end
    factory :false_choice do
      value { "false" }
      text { "false" }
      order { 2 }
    end
  end
end
