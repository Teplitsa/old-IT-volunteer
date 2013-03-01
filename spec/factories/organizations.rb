# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    association :user

    name            { Faker::Job.title[0...30] }
    property_type   { Faker::Lorem.paragraph }
    inn             { Faker::Lorem.word }
    kpp             { Faker::Lorem.word }
    website         { Faker::Internet.http_url }
    about           { Faker::Lorem.paragraph }
  end
end
