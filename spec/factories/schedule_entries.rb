# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule_entry do
    time_to_send Time.now
    participant
    schedule
    questionnaire
  end
end
