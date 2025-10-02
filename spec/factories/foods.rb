# frozen_string_literal: true

FactoryBot.define do
  factory :food do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    price { Faker::Commerce.price(range: 5.0..50.0) }
    association :user, factory: :restaurante
  end
end
