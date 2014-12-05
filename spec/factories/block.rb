FactoryGirl.define do
  factory :block do
    sequence(:label) { |n| "block_#{n}" }

    after(:build) do |block|
      block.block_questionnaires.append(build(:block_questionnaire, block: block))
    end
  end
end
