# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Food, type: :model do
  include_context "with restaurante and food"

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe "dependent destroy relationship" do
    let!(:orders) { create_list(:order, 2, food: food) }

    it "destroys associated orders when food is destroyed" do
      expect { food.destroy }.to change { Order.count }.by(-2)
    end
  end
end
