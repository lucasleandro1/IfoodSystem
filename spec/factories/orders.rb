# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user, factory: :user
    association :food
    association :pickup_address, factory: :address
    association :delivery_address, factory: :address
    payment_method { :pix }
    estimated_value { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    status { :pendente }
    requested_at { Time.current }
    quantity { 1 }
    item_description { "Test Item" }
  end
end
