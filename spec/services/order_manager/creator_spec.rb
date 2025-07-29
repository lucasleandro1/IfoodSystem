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

      it "creates a new order with correct attributes" do
        expect { subject.call }.to change { Order.count }.by(1)

        created_order = subject.call
        expect(created_order).to have_attributes(
          user: user,
          food: food,
          quantity: 2,
          payment_method: 'pix',
          status: 'pendente',
          estimated_value: food.price * 2,
          item_description: food.name
        )
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
    let(:invalid_params) do
      valid_params.merge(
        pickup_address_id: nil,
        delivery_address_id: nil,
        payment_method: nil,
        quantity: 0
      )
    end

    let(:service) { described_class.new(user: user, food_id: food.id, order_params: invalid_params) }

      it "raises ArgumentError with multiple validation messages" do
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
