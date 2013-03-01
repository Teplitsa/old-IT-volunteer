# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    association :owner,     factory: :user
    association :task_type
    association :prize

    title         { Faker::Job.title[0...30] }
    problem       { Faker::Lorem.paragraph }
    solution      { Faker::Lorem.paragraph }
    deadline      { Time.now.beginning_of_day + rand(1..3).day }
    state         1 # 'opened'
    location      {  Faker::Address.city }

    # image
    # file
    
  end
end
