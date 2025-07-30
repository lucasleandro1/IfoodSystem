# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Restaurant Management", type: :system do
  let(:cliente) { create(:user, role: :cliente, email: "client@test.com", password: "password123") }

  before { login_as(cliente, scope: :user) }

  describe "restaurant listing" do
    context "when restaurants exist" do
      it "displays list of restaurants" do
        create(:user, role: :restaurante, email: "pizza@place.com")
        create(:user, role: :restaurante, email: "burger@place.com")

        visit restaurantes_path

        expect(page).to have_content("restaurantes")
        expect(page).to have_content("Pizza")
        expect(page).to have_content("Burger")
      end
    end
  end

  describe "restaurant details" do
    let(:restaurant) { create(:user, role: :restaurante, email: "test@restaurant.com") }

    context "with complete restaurant information" do
      it "displays restaurant data and menu" do
        create(:address, user: restaurant, street: "Restaurant Street", number: "100")
        create(:food, user: restaurant, name: "Specialty Dish", price: 15.00)

        visit restaurante_path(restaurant)

        expect(page).to have_content("Test")
        expect(page).to have_content("Restaurant Street")
        expect(page).to have_content("Specialty Dish")
        expect(page).to have_content("15.00") || page.has_content?("15,00")
      end
    end

    context "with minimal restaurant information" do
      it "displays basic restaurant data" do
        visit restaurante_path(restaurant)

        expect(page).to have_content("Test")
      end
    end
  end

  describe "restaurant food ordering" do
    let(:restaurant) { create(:user, role: :restaurante) }
    let!(:food) { create(:food, user: restaurant, name: "Order Food", price: 20.00) }

    it "provides order link for available foods" do
      visit restaurante_path(restaurant)

      expect(page).to have_content("Order Food")
      expect(page).to have_link("Pedir")
    end
  end
end
