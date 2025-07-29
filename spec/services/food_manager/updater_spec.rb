# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodManager::Updater do
  let(:food) { create(:food) }
  let(:valid_params) { { name: 'Updated Pizza', description: 'Updated description', price: 30.00 } }
  let(:invalid_params) { { name: '', description: '', price: nil } }

  describe "#call" do
    context "with valid parameters" do
      subject { described_class.new(food, valid_params) }

      it "updates the food" do
        subject.call
        food.reload
        expect(food.name).to eq('Updated Pizza')
        expect(food.description).to eq('Updated description')
        expect(food.price).to eq(30.00)
      end

      it "returns success result" do
        result = subject.call
        expect(result[:success]).to be true
        expect(result[:message]).to eq("Produto atualizado com sucesso.")
        expect(result[:resource]).to eq(food)
      end
    end

    context "with invalid parameters" do
      subject { described_class.new(food, invalid_params) }

      it "does not update the food" do
        original_name = food.name
        subject.call
        food.reload
        expect(food.name).to eq(original_name)
      end

      it "returns error result" do
        result = subject.call
        expect(result[:success]).to be false
        expect(result[:error_message]).to include("can't be blank")
      end
    end

    context "when an exception occurs" do
      subject { described_class.new(food, valid_params) }

      before do
        allow(food).to receive(:update).and_raise(StandardError, "Database error")
      end

      it "handles exceptions gracefully" do
        result = subject.call
        expect(result[:success]).to be false
        expect(result[:error_message]).to eq("Database error")
      end
    end
  end
end
