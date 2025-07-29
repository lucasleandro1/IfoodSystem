# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodManager::Creator do
  include_context "with valid service params"
  include_context "with invalid service params"

  let(:restaurant) { create(:restaurant) }

  describe "#call" do
    context "with valid parameters" do
      subject { described_class.new(restaurant, valid_food_params) }
      include_examples "creator service", Food, "Produto criado com sucesso."

      it "associates food with the restaurant" do
        result = subject.call
        expect(result[:resource].user).to eq(restaurant)
      end
    end

    context "with invalid parameters" do
      subject { described_class.new(restaurant, invalid_food_params) }
      include_examples "failed service operation", "can't be blank"
    end

    context "when an exception occurs" do
      subject { described_class.new(restaurant, valid_food_params) }

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
