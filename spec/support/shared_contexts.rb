# frozen_string_literal: true

RSpec.shared_context "with user and address" do
  let(:user) { create(:user) }
  let(:address) { create(:address, user: user) }
end

RSpec.shared_context "with restaurante and food" do
  let(:restaurante) { create(:restaurante) }
  let(:food) { create(:food, user: restaurante) }
end

RSpec.shared_context "with complete order setup" do
  let(:user) { create(:user) }
  let(:restaurante) { create(:restaurante) }
  let(:food) { create(:food, user: restaurante) }
  let(:pickup_address) { create(:address, user: restaurante) }
  let(:delivery_address) { create(:address, user: user) }
  let(:order) { create(:order, user: user, food: food, pickup_address: pickup_address, delivery_address: delivery_address) }
end

RSpec.shared_context "with valid service params" do
  let(:valid_address_params) do
    { street: 'Rua das Flores', number: '123', neighborhood: 'Centro' }
  end

  let(:valid_food_params) do
    { name: 'Pizza Margherita', description: 'Delicious pizza', price: 25.50 }
  end

  let(:valid_order_params) do
    { payment_method: 'pix', estimated_value: 25.50 }
  end
end

RSpec.shared_context "with invalid service params" do
  let(:invalid_address_params) do
    { street: '', number: '', neighborhood: '' }
  end

  let(:invalid_food_params) do
    { name: '', description: '', price: nil }
  end
end
