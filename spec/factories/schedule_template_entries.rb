# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule_template_entry do
    time_offset_hours 24
    questionnaire
    schedule_template
  end
end
