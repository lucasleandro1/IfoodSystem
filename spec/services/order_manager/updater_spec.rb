# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderManager::Updater do
  let(:client) { create(:user, role: :client) }
  let(:restaurant) { create(:restaurant) }
  let(:food) { create(:food, user: restaurant) }
  let(:order) { create(:order, user: client, food: food, status: :pendente) }

  describe "#call" do
    context "client updates" do
      subject { described_class.new(user: client, order: order, status_param: 'cancelado') }

      it "allows cancellation of pending order" do
        expect(subject.call).to be true
        expect(order.reload.status).to eq('cancelado')
      end

      it "denies cancellation of non-pending order" do
        order.update!(status: :preparando)
        expect(subject.call).to be false
        expect(order.reload.status).to eq('preparando')
      end
    end

    context "restaurant updates" do
      %w[preparando em_rota entregue cancelado].each do |status|
        it "allows #{status} status update" do
          updater = described_class.new(user: restaurant, order: order, status_param: status)
          expect(updater.call).to be true
          expect(order.reload.status).to eq(status)
        end
      end
    end
  end
end
