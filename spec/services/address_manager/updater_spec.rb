# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressManager::Updater do
  subject(:updater) { described_class.new(user, address, params) }

  let(:user) { create(:user) }
  let(:address) { create(:address, user: user) }

  describe "#call" do
    context "when parameters are valid" do
      let(:params) do
        {
          street: 'Nova Rua',
          number: '456',
          neighborhood: 'Novo Bairro'
        }
      end

      it "updates the address attributes" do
        expect { updater.call }
          .to change { address.reload.street }.to('Nova Rua')
          .and change { address.number }.to('456')
          .and change { address.neighborhood }.to('Novo Bairro')
      end

      it "returns a successful" do
        result = updater.call

        expect(result).to include(
          success: true,
          message: "Endereço atualizado com sucesso.",
          resource: address
        )
      end
    end

    context "when parameters are invalid" do
      let(:params) do
        {
          street: '',
          number: '',
          neighborhood: ''
        }
      end

      it "does not update the address" do
        original_attributes = address.attributes.slice('street', 'number', 'neighborhood')

        updater.call

        expect(address.reload.attributes.slice('street', 'number', 'neighborhood'))
          .to eq(original_attributes)
      end

      it "returns an error result with validation messages" do
        result = updater.call

        expect(result).to include(
          success: false,
          error_message: a_string_including("can't be blank")
        )
      end
    end

    context "when allowing duplicate addresses" do
      let!(:existing_address) do
        create(:address,
               user: user,
               street: 'Rua Duplicada',
               number: '123',
               neighborhood: 'Bairro Duplicado')
      end

      let(:params) do
        {
          street: existing_address.street,
          number: existing_address.number,
          neighborhood: existing_address.neighborhood
        }
      end

      it "successfully updates to duplicate values" do
        result = updater.call

        expect(result[:success]).to be true
        expect(address.reload).to have_attributes(
          street: existing_address.street,
          number: existing_address.number,
          neighborhood: existing_address.neighborhood
        )
      end
    end

    context "when an unexpected error occurs" do
      let(:params) { { street: 'Test Street' } }
      let(:error_message) { "Unexpected database error" }

      before do
        allow(address).to receive(:update).and_raise(StandardError, error_message)
      end

      it "handles the exception gracefully" do
        result = updater.call

        expect(result).to include(
          success: false,
          error_message: error_message
        )
      end
    end
  end
end
