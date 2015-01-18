FactoryGirl.define do
  factory :answer_set do
    participant
    questionnaire
    schedule_entry

    factory :answer_set_with_answers do
      after(:build) do |answer_set|
        answer_set.answers <<
          create(:answer, answer_set: answer_set)
      end
    end
  end
end
