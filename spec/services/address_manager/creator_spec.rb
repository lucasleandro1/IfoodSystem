# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressManager::Creator do
  include_context "with valid service params"
  include_context "with invalid service params"

  let(:user) { create(:user) }

  describe "#call" do
    context "with valid parameters" do
      subject { described_class.new(user, valid_address_params) }
      include_examples "creator service", Address, "Endereço cadastrado com sucesso."

      it "associates address with the user" do
        result = subject.call
        expect(result[:resource].user).to eq(user)
      end
    end

    context "with invalid parameters" do
      subject { described_class.new(user, invalid_address_params) }
      include_examples "failed service operation"
    end

    context "when address already exists" do
      subject { described_class.new(user, valid_address_params) }
      before { create(:address, user: user, **valid_address_params) }

      it "does not create duplicate address" do
        expect { subject.call }.not_to change(Address, :count)
      end

      include_examples "failed service operation", "já existe"
    end

    context "when an exception occurs" do
      subject { described_class.new(user, valid_address_params) }
      before { allow(user.addresses).to receive(:exists?).and_raise(StandardError, "Database error") }

      include_examples "failed service operation", "Database error"
    end
  end
end
