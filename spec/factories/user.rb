require 'faker'

FactoryGirl.define do
  factory :user do
    sequence (:email) { |n| "person_#{n}@example.com" }
    password "secret"
    password_confirmation "secret"
    is_valid true

    factory :admin do
      is_admin true
    end
  end
end
