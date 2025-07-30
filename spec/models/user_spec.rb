# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:foods).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
  end

  describe "enums" do
    it { should define_enum_for(:role).with_values(cliente: 0, restaurante: 1) }
  end

  describe "default role" do
    it "sets default role to cliente" do
      user = User.new(email: "test@example.com", password: "password123")
      expect(user.role).to eq("cliente")
    end
  end
end
