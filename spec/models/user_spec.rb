require 'rails_helper'

RSpec.describe User, type: :model do
  it "é válido com nome, email e senha" do
    user = User.new(email: "lucas@cliente.com", password: "123456", role: :client)
    expect(user).to be_valid
  end

  it "não é válido sem um email" do
    user = User.new(password: "123456", role: :client)
    expect(user).not_to be_valid
  end

  it "não é válido sem um nome" do
    user = User.new(password: "123456", role: :client)
    expect(user).not_to be_valid
  end

  it "não é válido sem uma senha" do
    user = User.new(email: "lucas@cliente.com", role: :client)
    expect(user).not_to be_valid
  end
end
