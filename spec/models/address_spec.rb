require 'rails_helper'

RSpec.describe Address, type: :model do
  it "é válido com todos os campos preenchidos" do
    user = User.create!(email: "lucas@cliente.com", password: "123456", role: :client)
    address = Address.new(street: "Rua A", number: "123", neighborhood: "Centro", user: user)
    expect(address).to be_valid
  end

  it "não é válido sem um bairro" do
    user = User.create!(email: "lucas@cliente.com", password: "123456", role: :client)
    address = Address.new(street: "Rua A", number: "123", user: user)
    expect(address).not_to be_valid
  end
end
