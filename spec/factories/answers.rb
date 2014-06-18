# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    value "MyString"
    participant nil
    question nil
  end
end
