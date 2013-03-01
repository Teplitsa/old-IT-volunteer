# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    user nil
    organization nil
    body "MyString"
    value 1
  end
end
