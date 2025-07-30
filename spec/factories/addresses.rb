# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { "Rua 25 de Março" }
    number { "1020" }
    neighborhood { "Centro" }
    user
  end
end
