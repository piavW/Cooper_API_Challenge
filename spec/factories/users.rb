FactoryBot.define do
  factory :user do
    email { "name@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end