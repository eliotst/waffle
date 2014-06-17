# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    text "MyString?"
    label "MyString"
    user nil
  end
end
