# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer_validation do
    regular_expression "."
    answer_type
    factory :number_validation do
      regular_expression '\d+'
    end
  end
end
