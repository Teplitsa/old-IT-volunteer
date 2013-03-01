# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prize do
    name { Faker::HipsterIpsum.words(3).join(' ') }
  end
end
