# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule_template do
    study
    after(:build) do |schedule_template|
      schedule_template.schedule_template_entries.append(
        build(:schedule_template_entry, schedule_template: schedule_template))
    end
  end
end
