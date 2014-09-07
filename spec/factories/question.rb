FactoryGirl.define do
  factory :question do
    sequence(:label) { |n| "question_#{n}" }
    text "To be or not to be?"
    block
  end
end
