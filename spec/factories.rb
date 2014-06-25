require 'faker'

FactoryGirl.define do 
  factory :user do 
    sequence (:email) { |n| "person_#{n}@example.com" }
    password "secret" 
    password_confirmation "secret"

    factory :admin do
      admin true
    end
  end 

  factory :participant do
    user 
  end

  factory :question do
    text "MyString?"
    label "MyString"
    user 
  end

  factory :answer do
    value "MyString"
    participant 
    question 
  end
end
