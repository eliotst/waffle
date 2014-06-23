require 'faker'

FactoryGirl.define do 
  factory :user do 
    sequence (:email) { |n| "person_#{n}@example.com" }
    password "secret" 
    password_confirmation "secret"
    admin false

    factory :admin do
      admin true
    end
  end 

  factory :participant, parent: :user do
    user 
  end

  factory :question, parent: :user do
    text "MyString?"
    label "MyString"
    user 
  end

  factory :answer, parent: :participant, parent: :question do
    value "MyString"
    participant 
    question 
  end
end
