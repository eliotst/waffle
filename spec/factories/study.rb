FactoryGirl.define do
  factory :study do
    sequence(:title) { |n| "study #{n}" }
    sequence(:label) { |n| "study_#{n}" }

    factory :study_with_questionnaires do
      after(:build) do |study|
        study.questionnaires << create(:questionnaire, study: study)
      end
    end

    factory :study_with_schedule_templates do
      after(:build) do |study|
        study.schedule_templates << create(:schedule_template, study: study)
      end
    end
  end
end
