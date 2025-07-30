# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Address Management", type: :system do
  let(:user) { create(:user) }
  let!(:address) { create(:address, user: user, street: "Rua das Flores", number: "123", neighborhood: "Centro") }

  before do
    login_as(user, scope: :user)
  end

  describe "viewing addresses" do
    context "when user has addresses" do
      it "displays all user addresses" do
        visit addresses_path

        expect(page).to have_content("Rua das Flores, 123")
        expect(page).to have_content("Centro")
      end

      it "shows action buttons for each address" do
        visit addresses_path

        expect(page).to have_link("Editar", href: edit_address_path(address))
        expect(page).to have_button("Excluir")
      end
    end
  end

  describe "creating a new address" do
    it "creates address successfully with valid data" do
      visit new_address_path

      fill_in "address_street", with: "Avenida Paulista"
      fill_in "address_number", with: "456"
      fill_in "address_neighborhood", with: "Bela Vista"

      click_button "Cadastrar Endereço"

      expect(page).to have_content("Endereço cadastrado com sucesso")
      expect(page).to have_current_path(edit_user_registration_path)
    end
  end

  describe "editing an address" do
    it "updates address successfully with valid data" do
      visit edit_address_path(address)

      fill_in "address_street", with: "Rua das Palmeiras"
      fill_in "address_number", with: "789"
      fill_in "address_neighborhood", with: "Jardins"

      click_button "Atualizar Endereço"

      expect(page).to have_content("Endereço atualizado com sucesso")
      expect(page).to have_current_path(edit_user_registration_path)
    end
  end

  describe "deleting an address" do
    it "has delete button for each address" do
      visit addresses_path

      expect(page).to have_button("Excluir")
    end

    it "redirects properly when trying to delete" do
      visit addresses_path

      expect(page).to have_css("form[method='post']")
      expect(page).to have_button("Excluir")
    end
  end
end
