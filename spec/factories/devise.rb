require "faker"
FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    role { 1 }
  end
end
