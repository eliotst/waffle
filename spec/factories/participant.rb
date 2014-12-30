require 'faker'

FactoryGirl.define do
  factory :participant do
    user
    factory :participant_with_answers do
      after(:build) do |participant|
        participant.answers << create(:answer, participant: participant)
      end
    end
  end
end

