# Read about factories at https://github.com/thoughtbot/factory_girl
# encoding: utf-8

FactoryGirl.define do
  factory :user, class: User do |user|
    user.email                  { Faker::Internet.email }
    user.first_name             { Faker::Name.first_name }
    user.last_name              { Faker::Name.last_name }
    user.about                  { Faker::Lorem.words(22) }
    user.password "secret"
    user.password_confirmation  { |u| u.password }
    user.sex "m"
    # user.avatar
    # user.encrypted_password
    # user.reset_password_token
    # user.reset_password_sent_at
    # user.remember_created_at
    # user.sign_in_count
    # user.current_sign_in_at
    # user.last_sign_in_at
    # user.current_sign_in_ip
    # user.last_sign_in_ip
  end
end
