# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Food Management", type: :system do
  let(:restaurant) { create(:user, role: :restaurante, email: "restaurant@test.com", password: "password123") }
  let(:client) { create(:user, role: :cliente, email: "client@test.com", password: "password123") }

  describe "restaurant managing foods" do
    before { login_as(restaurant, scope: :user) }

    context "creating new food" do
      it "creates food with valid data" do
        visit foods_path
        click_link "Nova Comida"

        fill_in "food_name", with: "Margherita Pizza"
        fill_in "food_description", with: "Classic Italian pizza with fresh mozzarella"
        fill_in "food_price", with: "25.50"

        click_button "Criar Comida"

        expect(page).to have_content("Margherita Pizza")
        expect(page).to have_content("25.50") || page.has_content?("25,50")
      end

      it "shows validation errors with invalid data" do
        visit new_food_path
        click_button "Criar Comida"

        expect(page).to have_content("can't be blank") ||
                     page.has_content?("não pode ficar em branco")
      end
    end

    context "editing existing food" do
      let!(:food) { create(:food, user: restaurant, name: "Original Pizza", price: 25.00) }

      it "updates food successfully" do
        visit foods_path
        click_link "Editar"

        fill_in "food_name", with: "Updated Pizza"
        fill_in "food_price", with: "35.00"

        click_button "Atualizar Comida"

        expect(page).to have_content("Updated Pizza")
        expect(page).to have_content("35.00") || page.has_content?("35,00")
      end
    end

    context "deleting food" do
      let!(:food) { create(:food, user: restaurant, name: "Pizza to Delete") }

      it "removes food from list" do
        visit foods_path

        click_button "Excluir"

        expect(page).not_to have_content("Pizza to Delete")
      end
    end

    context "viewing own foods" do
      it "shows only own foods" do
        create(:food, user: restaurant, name: "My Pizza")
        other_user = create(:user, role: :restaurante)
        create(:food, user: other_user, name: "Other Pizza")

        visit foods_path

        expect(page).to have_content("My Pizza")
        expect(page).not_to have_content("Other Pizza")
      end
    end
  end

  describe "client viewing foods" do
    before { login_as(client, scope: :user) }

    context "browsing available foods" do
      it "shows all available foods" do
        create(:food, name: "Pizza Margherita", price: 25.50)
        create(:food, name: "Burger Classic", price: 18.90)

        visit foods_path

        expect(page).to have_content("Pizza Margherita")
        expect(page).to have_content("Burger Classic")
        expect(page).to have_content("25.50") || page.has_content?("25,50")
        expect(page).to have_content("18.90") || page.has_content?("18,90")
      end

      it "shows empty state when no foods exist" do
        visit foods_path

        expect(page).to have_content("Nenhuma comida disponível") ||
                     page.has_content?("Nenhum restaurante cadastrou comidas ainda.")
      end
    end

    context "viewing food details" do
      let!(:food) { create(:food, name: "Detailed Pizza", description: "Delicious pizza", price: 30.00) }

      it "displays food information" do
        visit foods_path
        click_link "Ver"

        expect(page).to have_content("Detailed Pizza")
        expect(page).to have_content("Delicious pizza")
        expect(page).to have_content("30.00") || page.has_content?("30,00")
      end
    end
  end
end
