require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  it "é válido com quantidade e preço" do
    client = User.create!(email: "lucas@cliente.com", password: "123456", role: :client)
    restaurant = User.create!(email: "pizza@top.com", password: "123456", role: :restaurant)
    pickup_address = Address.create!(street: "Rua A", number: "123", neighborhood: "Centro", user: client)
    delivery_address = Address.create!(street: "Rua C", number: "789", neighborhood: "Bairro Y", user: restaurant)
    order = Order.create!(user: client, pickup_address: pickup_address, delivery_address: delivery_address, item_description: "1 Pizza Calabresa", estimated_value: 39.90, payment_method: :cash, requested_at: Time.now)
    product = Product.create!(name: "Pizza Calabresa", description: "Pizza com calabresa", price: 39.90, user: restaurant)
    order_product = OrderProduct.new(order: order, product: product, quantity: 1, unit_price: 39.90)
    expect(order_product).to be_valid
  end

  it "não é válido sem quantidade" do
    order_product = OrderProduct.new(quantity: nil)
    expect(order_product).not_to be_valid
  end
end
