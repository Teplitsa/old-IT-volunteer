# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:uid)

  factory :authentication do
    association :user

    uid
    provider 'facebook'
  end
end
