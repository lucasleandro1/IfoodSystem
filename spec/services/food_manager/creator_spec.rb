require 'rails_helper'

RSpec.describe FoodManager::Creator do
  let(:restaurant) { create(:restaurant) }
  let(:valid_params) { { name: 'Pizza Margherita', description: 'Delicious pizza', price: 25.50 } }
  let(:invalid_params) { { name: '', description: '', price: nil } }

  describe "#call" do
    context "with valid parameters" do
      subject { described_class.new(restaurant, valid_params) }

      it "creates a new food" do
        expect { subject.call }.to change { Food.count }.by(1)
      end

      it "returns success result" do
        result = subject.call
        expect(result[:success]).to be true
        expect(result[:message]).to eq("Produto criado com sucesso.")
        expect(result[:resource]).to be_a(Food)
      end

      it "associates food with the restaurant" do
        result = subject.call
        food = result[:resource]
        expect(food.user).to eq(restaurant)
      end
    end

    context "with invalid parameters" do
      subject { described_class.new(restaurant, invalid_params) }

      it "does not create a food" do
        expect { subject.call }.not_to change { Food.count }
      end

      it "returns error result" do
        result = subject.call
        expect(result[:success]).to be false
        expect(result[:error_message]).to include("can't be blank")
      end
    end

    context "when an exception occurs" do
      subject { described_class.new(restaurant, valid_params) }

      before do
        allow(restaurant.foods).to receive(:build).and_raise(StandardError, "Database error")
      end

      it "handles exceptions gracefully" do
        result = subject.call
        expect(result[:success]).to be false
        expect(result[:error_message]).to eq("Database error")
      end
    end
  end
end
