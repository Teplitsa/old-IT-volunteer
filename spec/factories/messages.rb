# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    sender_id 1
    receiver_id 1
    body "MyText"
    branch_id 1
  end
end
