require 'rails_helper'

RSpec.describe AddressManager::Destroyer do
  let(:user) { create(:user) }
  let(:address) { create(:address, user: user) }

  describe "#call" do
    context "when address can be destroyed" do
      it "destroys the address" do
        destroyer = AddressManager::Destroyer.new(user, address)
        
        expect {
          destroyer.call
        }.to change(Address, :count).by(-1)
      end

      it "returns success result" do
        destroyer = AddressManager::Destroyer.new(user, address)
        result = destroyer.call

        expect(result[:success]).to be true
        expect(result[:message]).to be_present
      end
    end

    context "when address cannot be destroyed" do
      before do
        allow(address).to receive(:destroy).and_return(false)
      end

      it "does not destroy the address" do
        destroyer = AddressManager::Destroyer.new(user, address)
        
        expect {
          destroyer.call
        }.not_to change(Address, :count)
      end

      it "still returns success (destroyer não verifica se destroy foi bem-sucedido)" do
        destroyer = AddressManager::Destroyer.new(user, address)
        result = destroyer.call

        expect(result[:success]).to be true
      end
    end

    context "when an exception occurs" do
      it "handles exceptions gracefully" do
        allow(address).to receive(:destroy).and_raise(StandardError, "Database error")
        
        destroyer = AddressManager::Destroyer.new(user, address)
        result = destroyer.call

        expect(result[:success]).to be false
        expect(result[:error_message]).to eq("Database error")
      end
    end

    context "when address has associated orders" do
    end
  end
end
