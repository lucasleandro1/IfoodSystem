# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressManager::Destroyer do
  include_context "with user and address"

  describe "#call" do
    context "when address can be destroyed" do
      subject { described_class.new(user, address) }

      it "destroys the address" do
        address
        expect { subject.call }.to change(Address, :count).by(-1)
      end

      include_examples "successful service operation"
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
