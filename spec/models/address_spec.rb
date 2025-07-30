# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  include_context "with user and address"

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:pickup_orders).class_name("Order").with_foreign_key("pickup_address_id").dependent(:destroy) }
    it { should have_many(:delivery_orders).class_name("Order").with_foreign_key("delivery_address_id").dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:neighborhood) }
  end
end
