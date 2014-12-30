FactoryGirl.define do
  factory :questionnaire do
    sequence(:label) { |n| "questionnaire_#{n}" }
    study

    factory :questionnaire_with_blocks do
      after(:build) do |questionnaire|
        questionnaire.block_questionnaires <<
          create(:block_questionnaire, questionnaire: questionnaire)
      end
    end
  end
end
