# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    start_time Time.now
    participant
    schedule_template
  end
end
