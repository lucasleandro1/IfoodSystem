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

  describe "factory" do
    it "has a valid client factory" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.client?).to be true
    end

    it "has a valid restaurant factory" do
      restaurant = build(:restaurant)
      expect(restaurant).to be_valid
      expect(restaurant.restaurant?).to be true
    end
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

    it "client can have addresses and orders" do
      address = create(:address, user: client)
      order = create(:order, user: client)

      expect(client.addresses).to include(address)
      expect(client.orders).to include(order)
    end

    it "restaurant can have foods" do
      food = create(:food, user: restaurant)
      expect(restaurant.foods).to include(food)
    end
  end

  describe "dependent destroy" do
    let(:user) { create(:user) }
    let!(:address) { create(:address, user: user) }
    let!(:order) { create(:order, user: user) }

    it "destroys associated records when user is destroyed" do
      expect { user.destroy }.to change { Address.count }.by(-1)
                            .and change { Order.count }.by(-1)
    end
  end

  describe "restaurant with foods" do
    let(:restaurant) { create(:restaurant) }
    let!(:food1) { create(:food, user: restaurant) }
    let!(:food2) { create(:food, user: restaurant) }

    it "destroys associated foods when restaurant is destroyed" do
      expect { restaurant.destroy }.to change { Food.count }.by(-2)
    end
  end
end
