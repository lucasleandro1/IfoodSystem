require 'rails_helper'

RSpec.describe AddressManager::Creator do
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      street: 'Rua das Flores',
      number: '123',
      neighborhood: 'Centro'
    }
  end
  let(:invalid_params) do
    {
      street: '',
      number: '',
      neighborhood: ''
    }
  end

  describe "#call" do
    context "with valid parameters" do
      it "creates a new address" do
        creator = AddressManager::Creator.new(user, valid_params)
        
        expect {
          creator.call
        }.to change(Address, :count).by(1)
      end

      it "returns success result" do
        creator = AddressManager::Creator.new(user, valid_params)
        result = creator.call

        expect(result[:success]).to be true
        expect(result[:message]).to be_present
        expect(result[:resource]).to be_an(Address)
      end

      it "associates address with the user" do
        creator = AddressManager::Creator.new(user, valid_params)
        result = creator.call

        expect(result[:resource].user).to eq(user)
      end
    end

    context "with invalid parameters" do
      it "does not create an address" do
        creator = AddressManager::Creator.new(user, invalid_params)
        
        expect {
          creator.call
        }.not_to change(Address, :count)
      end

      it "returns error result" do
        creator = AddressManager::Creator.new(user, invalid_params)
        result = creator.call

        expect(result[:success]).to be false
        expect(result[:error_message]).to be_present
      end
    end

    context "when address already exists" do
      let!(:existing_address) { create(:address, user: user, street: 'Rua das Flores', number: '123', neighborhood: 'Centro') }

      it "does not create duplicate address" do
        creator = AddressManager::Creator.new(user, valid_params)
        
        expect {
          creator.call
        }.not_to change(Address, :count)
      end

      it "returns error about existing address" do
        creator = AddressManager::Creator.new(user, valid_params)
        result = creator.call

        expect(result[:success]).to be false
        expect(result[:error_message]).to include("já existe")
      end
    end

    context "when an exception occurs" do
      it "handles exceptions gracefully" do
        allow(user.addresses).to receive(:exists?).and_raise(StandardError, "Database error")
        
        creator = AddressManager::Creator.new(user, valid_params)
        result = creator.call

        expect(result[:success]).to be false
        expect(result[:error_message]).to eq("Database error")
      end
    end
  end
end
