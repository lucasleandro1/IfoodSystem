require 'rails_helper'

RSpec.describe Product, type: :model do
  it "é válido com nome, preço e descrição" do
    restaurant = User.create!(email: "pizza@top.com", password: "123456", role: :restaurant)
    product = Product.new(name: "Pizza Calabresa", description: "Pizza com calabresa", price: 39.90, user: restaurant)
    expect(product).to be_valid
  end

  it "não é válido sem preço" do
    restaurant = User.create!(email: "pizza@top.com", password: "123456", role: :restaurant)
    product = Product.new(name: "Pizza Calabresa", description: "Pizza com calabresa", user: restaurant)
    expect(product).not_to be_valid
  end
end
