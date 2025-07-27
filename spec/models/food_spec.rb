require 'rails_helper'

RSpec.describe Food, type: :model do
  it "é válido com nome, preço e descrição" do
    restaurant = User.create!(email: "pizza@top.com", password: "123456", role: :restaurant)
    food = Food.new(name: "Pizza Calabresa", description: "Pizza com calabresa", price: 39.90, user: restaurant)
    expect(food).to be_valid
  end

  it "não é válido sem preço" do
    restaurant = User.create!(email: "pizza@top.com", password: "123456", role: :restaurant)
    food = Food.new(name: "Pizza Calabresa", description: "Pizza com calabresa", user: restaurant)
    expect(food).not_to be_valid
  end
end
