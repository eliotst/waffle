require 'faker'

FactoryGirl.define do 
  factory :user do |f| 
    f.email { |n| "person_#{n}@example.com" }
    f.password "foobar" 
    f.password_confirmation "foobar"
  end
  factory :admin do
    admin true
  end 
end