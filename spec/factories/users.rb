# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
    role { :cliente }
  end

  factory :restaurante, parent: :user do
    email { Faker::Internet.unique.email(domain: 'restaurante.com') }
    role { :restaurante }
  end
end
