require 'rails_helper'

RSpec.describe OrderManager::Creator do
  let(:user) { create(:user) }
  let(:food) { create(:food) }
  let(:pickup_address) { create(:address) }
  let(:delivery_address) { create(:address) }
  let(:valid_params) do
    {
      quantity: 2,
      pickup_address_id: pickup_address.id,
      delivery_address_id: delivery_address.id,
      payment_method: 'pix'
    }
  end

  describe "#call" do
    context "with valid parameters" do
      subject { described_class.new(user: user, food_id: food.id, order_params: valid_params) }

      it "creates a new order" do
        expect { subject.call }.to change { Order.count }.by(1)
      end

      it "sets correct order attributes" do
        order = subject.call
        expect(order.user).to eq(user)
        expect(order.food).to eq(food)
        expect(order.quantity).to eq(2)
        expect(order.pickup_address_id).to eq(pickup_address.id)
        expect(order.delivery_address_id).to eq(delivery_address.id)
        expect(order.payment_method).to eq('pix')
        expect(order.status).to eq('pendente')
      end

      it "calculates estimated value correctly" do
        order = subject.call
        expected_value = food.price * 2
        expect(order.estimated_value).to eq(expected_value)
      end

      it "sets item description from food name" do
        order = subject.call
        expect(order.item_description).to eq(food.name)
      end
    end

    context "with invalid food_id" do
      it "raises ActiveRecord::RecordNotFound" do
        expect {
          described_class.new(user: user, food_id: 99999, order_params: valid_params)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with missing required parameters" do
      it "raises ArgumentError for missing pickup_address_id" do
        invalid_params = valid_params.merge(pickup_address_id: nil)
        service = described_class.new(user: user, food_id: food.id, order_params: invalid_params)
        
        expect {
          service.call
        }.to raise_error(ArgumentError, /Endereço de coleta é obrigatório/)
      end

      it "raises ArgumentError for missing delivery_address_id" do
        invalid_params = valid_params.merge(delivery_address_id: nil)
        service = described_class.new(user: user, food_id: food.id, order_params: invalid_params)
        
        expect {
          service.call
        }.to raise_error(ArgumentError, /Endereço de entrega é obrigatório/)
      end

      it "raises ArgumentError for missing payment_method" do
        invalid_params = valid_params.merge(payment_method: nil)
        service = described_class.new(user: user, food_id: food.id, order_params: invalid_params)
        
        expect {
          service.call
        }.to raise_error(ArgumentError, /Método de pagamento é obrigatório/)
      end

      it "raises ArgumentError for invalid quantity" do
        invalid_params = valid_params.merge(quantity: 0)
        service = described_class.new(user: user, food_id: food.id, order_params: invalid_params)
        
        expect {
          service.call
        }.to raise_error(ArgumentError, /Quantidade deve ser maior que zero/)
      end

      it "raises ArgumentError with multiple errors" do
        invalid_params = {
          quantity: 0,
          pickup_address_id: nil,
          delivery_address_id: nil,
          payment_method: nil
        }
        service = described_class.new(user: user, food_id: food.id, order_params: invalid_params)
        
        expect {
          service.call
        }.to raise_error(ArgumentError) do |error|
          expect(error.message).to include("Endereço de coleta é obrigatório")
          expect(error.message).to include("Endereço de entrega é obrigatório")
          expect(error.message).to include("Método de pagamento é obrigatório")
          expect(error.message).to include("Quantidade deve ser maior que zero")
        end
      end
    end
  end
end
