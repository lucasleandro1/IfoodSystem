# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:foods).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe "enums" do
    it { should define_enum_for(:role).with_values(cliente: 0, restaurante: 1) }
  end

  describe "default role" do
    it "sets default role to cliente" do
      user = User.new(email: "test@example.com", password: "password123")
      expect(user.role).to eq("cliente")
    end
  end

  describe "role behaviors" do
    let(:cliente) { create(:user, role: :cliente) }
    let(:restaurante) { create(:user, role: :restaurante) }
    let(:address) { create(:address, user: cliente) }
    let(:order) { create(:order, user: cliente) }
    let(:food) { create(:food, user: restaurante) }

    it "associates records correctly by role" do
      expect(cliente.addresses).to include(address)
      expect(cliente.orders).to include(order)
    end

    it "restaurante can have foods" do
      food = create(:food, user: restaurante)
      expect(restaurante.foods).to include(food)
    end
  end
end
