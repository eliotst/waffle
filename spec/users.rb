require 'faker'

FactoryGirl.define do 
  factory :user do |f| 
    f.email { |n| "person_#{n}@example.com" }
    f.password "secret" 
    f.password_confirmation "secret"
  end
  factory :admin do
    admin true
  end 
end