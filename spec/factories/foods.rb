# frozen_string_literal: true

FactoryBot.define do
  factory :food do
    name { "Hamburguer" }
    description { 'Dois hambúrgueres, queijo, alface, cebola e molho especial' }
    price { 10.00 }
    association :user, factory: :restaurante
  end
end
