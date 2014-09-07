FactoryGirl.define do
  factory :questionnaire do
    sequence(:label) { |n| "questionnaire_#{n}" }
    study
  end
end
