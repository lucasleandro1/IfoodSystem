# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    role { :cliente }
  end

  factory :restaurante, parent: :user do
    role { :restaurante }
  end
end
