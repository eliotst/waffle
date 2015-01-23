require 'faker'

FactoryGirl.define do
  factory :participant do
    user
    study { create(:study_with_schedule_templates) }
    factory :participant_with_answers do
      after(:build) do |participant|
        participant.answers << create(:answer, participant: participant)
      end
    end
  end
end

