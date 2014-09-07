FactoryGirl.define do
  factory :answer do
    participant
    question
    value "42"
  end
end
