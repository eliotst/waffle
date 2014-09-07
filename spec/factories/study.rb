FactoryGirl.define do
  factory :study do
    sequence(:title) { |n| "study #{n}" }
  end
end
