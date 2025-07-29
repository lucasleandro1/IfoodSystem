require 'rails_helper'

RSpec.describe Food, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe "factory" do
    it "has a valid factory" do
      food = build(:food)
      expect(food).to be_valid
    end
  end

  describe "when created with valid attributes" do
    let(:food) { create(:food) }

    it "belongs to a restaurant user" do
      expect(food.user).to be_present
      expect(food.user.restaurant?).to be true
    end

    it "has required attributes" do
      expect(food.name).to be_present
      expect(food.description).to be_present
      expect(food.price).to be > 0
    end
  end

  describe "invalid foods" do
    it "is invalid without name" do
      food = build(:food, name: nil)
      expect(food).not_to be_valid
      expect(food.errors[:name]).to include("can't be blank")
    end

    it "is invalid without description" do
      food = build(:food, description: nil)
      expect(food).not_to be_valid
      expect(food.errors[:description]).to include("can't be blank")
    end

    it "is invalid without price" do
      food = build(:food, price: nil)
      expect(food).not_to be_valid
      expect(food.errors[:price]).to include("can't be blank")
    end

    it "is invalid with zero price" do
      food = build(:food, price: 0)
      expect(food).not_to be_valid
      expect(food.errors[:price]).to include("must be greater than 0")
    end

    it "is invalid with negative price" do
      food = build(:food, price: -10)
      expect(food).not_to be_valid
      expect(food.errors[:price]).to include("must be greater than 0")
    end

    it "is invalid without user" do
      food = build(:food, user: nil)
      expect(food).not_to be_valid
      expect(food.errors[:user]).to include("must exist")
    end
  end

  describe "relationships with orders" do
    let(:food) { create(:food) }
    let!(:order1) { create(:order, food: food) }
    let!(:order2) { create(:order, food: food) }

    it "can be destroyed and removes associated orders" do
      expect { food.destroy }.to change { Order.count }.by(-2)
      expect(Order.where(id: [order1.id, order2.id])).to be_empty
    end
  end
end
