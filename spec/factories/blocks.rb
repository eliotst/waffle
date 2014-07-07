# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :block, :class => 'Blocks' do
    label "MyString"
    question nil
  end
end
