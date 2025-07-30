# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "client#{n}@test.com" }
    password { "password123" }
    password_confirmation { "password123" }
    role { :cliente }
  end

  factory :restaurante, parent: :user do
    sequence(:email) { |n| "restaurante#{n}@test.com" }
    role { :restaurante }
  end
end
