require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:food) }
    it { should belong_to(:pickup_address).class_name('Address') }
    it { should belong_to(:delivery_address).class_name('Address') }
  end

  describe "validations" do
    it { should validate_presence_of(:payment_method) }
    it { should validate_presence_of(:pickup_address) }
    it { should validate_presence_of(:delivery_address) }
    it { should validate_presence_of(:user) }
    it { should validate_numericality_of(:estimated_value).is_greater_than(0) }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values(pendente: 0, cancelado: 1, preparando: 2, em_rota: 3, entregue: 4) }
    it { should define_enum_for(:payment_method).with_values(pix: 0, card: 1, cash: 2) }
  end

  describe "factory" do
    it "has a valid factory" do
      order = build(:order)
      expect(order).to be_valid
    end
  end

  describe "when created with valid attributes" do
    let(:order) { create(:order) }

    it "has all required associations" do
      expect(order.user).to be_present
      expect(order.food).to be_present
      expect(order.pickup_address).to be_present
      expect(order.delivery_address).to be_present
    end

    it "has valid payment method and status" do
      expect(order.payment_method).to be_present
      expect(order.status).to eq('pendente')
      expect(order.estimated_value).to be > 0
    end
  end

  describe "invalid orders" do
    it "is invalid without user" do
      order = build(:order, user: nil)
      expect(order).not_to be_valid
      expect(order.errors[:user]).to include("must exist")
    end

    it "is invalid without food" do
      order = build(:order, food: nil)
      expect(order).not_to be_valid
      expect(order.errors[:food]).to include("must exist")
    end

    it "is invalid without pickup_address" do
      order = build(:order, pickup_address: nil)
      expect(order).not_to be_valid
      expect(order.errors[:pickup_address]).to include("can't be blank")
    end

    it "is invalid without delivery_address" do
      order = build(:order, delivery_address: nil)
      expect(order).not_to be_valid
      expect(order.errors[:delivery_address]).to include("can't be blank")
    end

    it "is invalid without payment_method" do
      order = build(:order, payment_method: nil)
      expect(order).not_to be_valid
      expect(order.errors[:payment_method]).to include("can't be blank")
    end

    it "is invalid with zero estimated_value" do
      order = build(:order, estimated_value: 0)
      expect(order).not_to be_valid
      expect(order.errors[:estimated_value]).to include("must be greater than 0")
    end

    it "is invalid with negative estimated_value" do
      order = build(:order, estimated_value: -10)
      expect(order).not_to be_valid
      expect(order.errors[:estimated_value]).to include("must be greater than 0")
    end
  end

  describe "status transitions" do
    let(:order) { create(:order) }

    it "starts with pendente status" do
      expect(order.pendente?).to be true
    end

    it "can transition through statuses" do
      order.preparando!
      expect(order.preparando?).to be true

      order.em_rota!
      expect(order.em_rota?).to be true

      order.entregue!
      expect(order.entregue?).to be true
    end

    it "can be cancelled" do
      order.cancelado!
      expect(order.cancelado?).to be true
    end
  end

  describe "payment methods" do
    let(:order) { create(:order) }

    it "supports pix payment" do
      order.update!(payment_method: :pix)
      expect(order.pix?).to be true
    end

    it "supports card payment" do
      order.update!(payment_method: :card)
      expect(order.card?).to be true
    end

    it "supports cash payment" do
      order.update!(payment_method: :cash)
      expect(order.cash?).to be true
    end
  end
end
