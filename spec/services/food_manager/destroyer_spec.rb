# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodManager::Destroyer do
  let!(:food) { create(:food) }

  describe "#call" do
    context "when food can be destroyed" do
      subject { described_class.new(food) }

      it "destroys the food" do
        expect { subject.call }.to change { Food.count }.by(-1)
      end

      include_examples "successful service operation", "Produto excluído com sucesso."
    end

    context "when food cannot be destroyed" do
      subject { described_class.new(food) }

      before do
        allow(food).to receive(:destroy).and_return(false)
      end

      it "does not destroy the food" do
        expect { subject.call }.not_to change { Food.count }
      end

      it "returns error result" do
        result = subject.call
        expect(result[:success]).to be false
        expect(result[:error_message]).to eq("Erro ao excluir o produto.")
      end
    end
  end
end
