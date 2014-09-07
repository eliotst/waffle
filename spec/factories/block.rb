FactoryGirl.define do
  factory :block do
    sequence(:label) { |n| "block_#{n}" }
  end
end
