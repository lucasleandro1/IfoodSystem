require 'rails_helper'

RSpec.describe Order, type: :model do
  it "é válido com todos os campos preenchidos" do
    client = User.create!(email: "lucas@cliente.com", password: "123456", role: :client)
    restaurant = User.create!(email: "pizza@top.com", password: "123456", role: :restaurant)
    pickup_address = Address.create!(street: "Rua A", number: "123", neighborhood: "Centro", user: client)
    delivery_address = Address.create!(street: "Rua C", number: "789", neighborhood: "Bairro Y", user: restaurant)
    order = Order.new(user: client, pickup_address: pickup_address, delivery_address: delivery_address, item_description: "1 Pizza Calabresa", estimated_value: 39.90, payment_method: :cash, requested_at: Time.now)
    expect(order).to be_valid
  end

  it "não é válido sem estimated_value" do
    client = User.create!(email: "lucas@cliente.com", password: "123456", role: :client)
    restaurant = User.create!(email: "pizza@top.com", password: "123456", role: :restaurant)
    pickup_address = Address.create!(street: "Rua A", number: "123", neighborhood: "Centro", user: client)
    delivery_address = Address.create!(street: "Rua C", number: "789", neighborhood: "Bairro Y", user: restaurant)
    order = Order.new(user: client, pickup_address: pickup_address, delivery_address: delivery_address, item_description: "1 Pizza Calabresa", payment_method: :cash, requested_at: Time.now)
    expect(order).not_to be_valid
  end
end
