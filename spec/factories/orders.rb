# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user, factory: :user
    association :food
    association :pickup_address, factory: :address
    association :delivery_address, factory: :address
    payment_method { [ :pix, :cartao_credito, :cartao_debito, :dinheiro ].sample }
    estimated_value { Faker::Commerce.price(range: 10.0..100.0) }
    status { [ :pendente, :preparando, :saiu_para_entrega, :entregue, :cancelado ].sample }
    requested_at { Faker::Time.between(from: 30.days.ago, to: Time.current) }
    quantity { Faker::Number.between(from: 1, to: 5) }
    item_description { Faker::Food.description }
  end
end
