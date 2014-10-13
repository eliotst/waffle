FactoryGirl.define do
  factory :study do
    sequence(:title) { |n| "study #{n}" }
    sequence(:label) { |n| "study_#{n}" }
  end
end
