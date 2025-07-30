# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Order Management", type: :system do
  let(:cliente) { create(:user, email: "client@test.com", password: "password123", role: :cliente) }
  let(:restaurante) { create(:user, email: "restaurant@test.com", password: "password123", role: :restaurante) }
  let(:food) { create(:food, user: restaurante, name: "Margherita Pizza", price: 25.50) }
  let(:client_address) { create(:address, user: cliente, street: "Main Street", number: "123", neighborhood: "Downtown") }
  let(:restaurant_address) { create(:address, user: restaurante, street: "Oak Street", number: "456", neighborhood: "Uptown") }

  before do
    client_address
    restaurant_address
  end

  describe "order creation" do
    before { login_as(cliente, scope: :user) }

    context "with valid data" do
      it "creates order successfully" do
        visit new_order_path(food_id: food.id)

        expect(page).to have_content("Finalizar Pedido")
        expect(page).to have_content("Margherita Pizza")

        fill_in "order_quantity", with: "2"
        select_address_option(restaurant_address, "order_pickup_address_id")
        select_address_option(client_address, "order_delivery_address_id")
        select "Pix", from: "order_payment_method"

        click_button "Finalizar Pedido"

        expect(page).to have_current_path(/\/orders\/\d+/)
        expect(page).to have_content("Pedido criado com sucesso")
        expect(page).to have_content("Margherita Pizza")
      end
    end

    context "with missing required fields" do
      it "shows validation errors" do
        visit new_order_path(food_id: food.id)
        click_button "Finalizar Pedido"

        expect(page).to have_current_path(/orders.*food_id/)
        expect(page).to have_content("Finalizar Pedido")
      end
    end

    context "validating quantity" do
      it "requires quantity greater than zero" do
        visit new_order_path(food_id: food.id)

        fill_in "order_quantity", with: "0"
        select_address_option(restaurant_address, "order_pickup_address_id")
        select_address_option(client_address, "order_delivery_address_id")
        select "Pix", from: "order_payment_method"

        click_button "Finalizar Pedido"

        expect(page).to have_content("Quantidade deve ser maior que zero")
      end
    end

    context "validating addresses" do
      it "requires pickup address" do
        visit new_order_path(food_id: food.id)

        fill_in "order_quantity", with: "1"
        select_address_option(client_address, "order_delivery_address_id")
        select "Pix", from: "order_payment_method"

        click_button "Finalizar Pedido"

        expect(page).to have_content("Endereço de coleta é obrigatório")
      end

      it "requires delivery address" do
        visit new_order_path(food_id: food.id)

        fill_in "order_quantity", with: "1"
        select_address_option(restaurant_address, "order_pickup_address_id")
        select "Pix", from: "order_payment_method"

        click_button "Finalizar Pedido"

        expect(page).to have_content("Endereço de entrega é obrigatório")
      end
    end
  end

  private

  def select_address_option(address, field_name)
    address_text = "#{address.street}, #{address.number} - #{address.neighborhood}"
    select address_text, from: field_name
  end
end
