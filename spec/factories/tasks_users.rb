# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tasks_user do
    task nil
    user nil
    role "MyString"
  end
end
