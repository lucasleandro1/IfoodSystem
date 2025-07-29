require 'rails_helper'

RSpec.describe OrderManager::Updater do
  let(:client) { create(:user, role: :client) }
  let(:restaurant) { create(:restaurant) }
  let(:food) { create(:food, user: restaurant) }
  let(:order) { create(:order, user: client, food: food, status: :pendente) }

  describe "#call" do
    context "when client updates their own pending order" do
      subject { described_class.new(user: client, order: order, status_param: 'cancelado') }

      it "allows cancellation" do
        result = subject.call
        expect(result).to be true
        expect(order.reload.status).to eq('cancelado')
      end
    end

    context "when restaurant updates order for their food" do
      subject { described_class.new(user: restaurant, order: order, status_param: 'preparando') }

      it "allows status update" do
        result = subject.call
        expect(result).to be true
        expect(order.reload.status).to eq('preparando')
      end

      it "allows marking as em_rota" do
        updater = described_class.new(user: restaurant, order: order, status_param: 'em_rota')
        result = updater.call
        expect(result).to be true
        expect(order.reload.status).to eq('em_rota')
      end

      it "allows marking as entregue" do
        updater = described_class.new(user: restaurant, order: order, status_param: 'entregue')
        result = updater.call
        expect(result).to be true
        expect(order.reload.status).to eq('entregue')
      end
    end

    context "authorization checks" do
      let(:other_client) { create(:user, role: :client) }
      let(:other_restaurant) { create(:restaurant) }

      it "denies access to other client's order" do
        subject = described_class.new(user: other_client, order: order, status_param: 'cancelado')
        result = subject.call
        expect(result).to be false
        expect(order.reload.status).to eq('pendente')
      end

      it "denies access to other restaurant's order" do
        subject = described_class.new(user: other_restaurant, order: order, status_param: 'preparando')
        result = subject.call
        expect(result).to be false
        expect(order.reload.status).to eq('pendente')
      end

      it "denies client updates for non-pending orders" do
        order.update!(status: :preparando)
        subject = described_class.new(user: client, order: order, status_param: 'cancelado')
        result = subject.call
        expect(result).to be false
        expect(order.reload.status).to eq('preparando')
      end
    end

    context "cancel requests" do
      it "allows restaurant to cancel their order" do
        subject = described_class.new(user: restaurant, order: order, status_param: 'cancelado')
        result = subject.call
        expect(result).to be true
        expect(order.reload.status).to eq('cancelado')
      end

      it "allows client to cancel pending order" do
        subject = described_class.new(user: client, order: order, status_param: 'cancelado')
        result = subject.call
        expect(result).to be true
        expect(order.reload.status).to eq('cancelado')
      end
    end
  end
end
