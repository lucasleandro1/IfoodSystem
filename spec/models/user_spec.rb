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
    it { should define_enum_for(:role).with_values(client: 0, restaurant: 1) }
  end

  describe "default role" do
    it "sets default role to client" do
      user = User.new(email: "test@example.com", password: "password123")
      expect(user.role).to eq("client")
    end
  end

  describe "role behaviors" do
    let(:client) { create(:user, role: :client) }
    let(:restaurant) { create(:user, role: :restaurant) }
    let(:address) { create(:address, user: client) }
    let(:order) { create(:order, user: client) }
    let(:food) { create(:food, user: restaurant) }

    it "associates records correctly by role" do
      expect(client.addresses).to include(address)
      expect(client.orders).to include(order)
    end

    it "restaurant can have foods" do
      food = create(:food, user: restaurant)
      expect(restaurant.foods).to include(food)
    end
  end
end
