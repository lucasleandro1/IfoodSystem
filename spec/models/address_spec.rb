require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:pickup_orders).class_name("Order").with_foreign_key("pickup_address_id").dependent(:destroy) }
    it { should have_many(:delivery_orders).class_name("Order").with_foreign_key("delivery_address_id").dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:neighborhood) }
  end

  describe "factory" do
    it "has a valid factory" do
      address = build(:address)
      expect(address).to be_valid
    end
  end

  describe "when created with valid attributes" do
    let(:user) { create(:user) }
    let(:address) { create(:address, user: user) }

    it "belongs to a user" do
      expect(address.user).to eq(user)
    end

    it "has required attributes" do
      expect(address.street).to be_present
      expect(address.number).to be_present
      expect(address.neighborhood).to be_present
    end
  end

  describe "invalid addresses" do
    it "is invalid without street" do
      address = build(:address, street: nil)
      expect(address).not_to be_valid
      expect(address.errors[:street]).to include("can't be blank")
    end

    it "is invalid without number" do
      address = build(:address, number: nil)
      expect(address).not_to be_valid
      expect(address.errors[:number]).to include("can't be blank")
    end

    it "is invalid without neighborhood" do
      address = build(:address, neighborhood: nil)
      expect(address).not_to be_valid
      expect(address.errors[:neighborhood]).to include("can't be blank")
    end

    it "is invalid without user" do
      address = build(:address, user: nil)
      expect(address).not_to be_valid
      expect(address.errors[:user]).to include("must exist")
    end
  end

  describe "relationships with orders" do
    let(:address) { create(:address) }

    it "can be destroyed and removes associated pickup orders" do
      expect { address.destroy }.not_to raise_error
    end

    it "can be destroyed and removes associated delivery orders" do
      expect { address.destroy }.not_to raise_error
    end
  end
end
