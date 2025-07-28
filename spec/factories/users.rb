FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    role { :client }
  end

  factory :restaurant, parent: :user do
    role { :restaurant }
  end
end
