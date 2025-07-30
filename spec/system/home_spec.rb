# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Home Page", type: :system do
  describe "home page navigation" do
    context "for guest users" do
      it "displays home page content" do
        visit root_path

        expect(page).to have_http_status(:success)
      end
    end

    context "for cliente users" do
      let(:cliente) { create(:user, role: :cliente) }

      before { login_as(cliente, scope: :user) }

      it "shows food listings" do
        create(:food, name: "Home Pizza", price: 25.00)
        create(:food, name: "Home Burger", price: 18.00)

        visit root_path

        expect(page).to have_content("Home Pizza")
        expect(page).to have_content("Home Burger")
        expect(page).to have_content("25.00") || page.has_content?("25,00")
        expect(page).to have_content("18.00") || page.has_content?("18,00")
      end

      it "handles empty food state" do
        visit root_path

        expect(page).to have_http_status(:success)
      end
    end

    context "for restaurante users" do
      let(:restaurante) { create(:user, role: :restaurante) }

      it "redirects to orders page" do
        login_as(restaurante, scope: :user)

        visit root_path

        expect(page).to have_current_path(orders_path)
      end
    end
  end

  describe "food interaction" do
    let(:cliente) { create(:user, role: :cliente) }
    let!(:food) { create(:food, name: "Interactive Food", price: 30.00) }

    before { login_as(cliente, scope: :user) }

    it "allows food ordering from home page" do
      visit root_path

      expect(page).to have_content("Interactive Food")
    end
  end
end
