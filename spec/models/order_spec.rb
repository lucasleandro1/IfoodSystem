# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  include_context "with complete order setup"

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

  describe "valid order creation" do
    it "creates with all required associations and attributes" do
      expect(order).to be_valid
      expect(order.status).to eq('pendente')
      expect(order.estimated_value).to be > 0
      expect(order.user).to be_present
      expect(order.food).to be_present
      expect(order.pickup_address).to be_present
      expect(order.delivery_address).to be_present
    end
  end
end
