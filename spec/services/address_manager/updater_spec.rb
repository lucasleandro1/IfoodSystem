require 'rails_helper'

RSpec.describe AddressManager::Updater do
  let(:user) { create(:user) }
  let(:address) { create(:address, user: user) }
  let(:valid_params) do
    {
      street: 'Nova Rua',
      number: '456',
      neighborhood: 'Novo Bairro'
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
      it "updates the address" do
        updater = AddressManager::Updater.new(user, address, valid_params)
        result = updater.call

        address.reload
        expect(address.street).to eq('Nova Rua')
        expect(address.number).to eq('456')
        expect(address.neighborhood).to eq('Novo Bairro')
      end

      it "returns success result" do
        updater = AddressManager::Updater.new(user, address, valid_params)
        result = updater.call

        expect(result[:success]).to be true
        expect(result[:message]).to be_present
        expect(result[:resource]).to eq(address)
      end
    end

    context "with invalid parameters" do
      it "does not update the address" do
        original_street = address.street
        updater = AddressManager::Updater.new(user, address, invalid_params)
        result = updater.call

        address.reload
        expect(address.street).to eq(original_street)
      end

      it "returns error result" do
        updater = AddressManager::Updater.new(user, address, invalid_params)
        result = updater.call

        expect(result[:success]).to be false
        expect(result[:error_message]).to be_present
      end
    end

    context "when trying to create duplicate address" do
      let!(:existing_address) { create(:address, user: user, street: 'Rua Existente', number: '789', neighborhood: 'Bairro Existente') }
      let(:duplicate_params) do
        {
          street: 'Rua Existente',
          number: '789',
          neighborhood: 'Bairro Existente'
        }
      end

      it "updates address even if it creates duplicate (no validation for duplicates in updater)" do
        updater = AddressManager::Updater.new(user, address, duplicate_params)
        result = updater.call

        # O updater atual não valida duplicatas, então deve ser bem-sucedido
        expect(result[:success]).to be true
      end
    end

    context "when an exception occurs" do
      it "handles exceptions gracefully" do
        allow(address).to receive(:update).and_raise(StandardError, "Database error")
        
        updater = AddressManager::Updater.new(user, address, valid_params)
        result = updater.call

        expect(result[:success]).to be false
        expect(result[:error_message]).to eq("Database error")
      end
    end
  end
end
