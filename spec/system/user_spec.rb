# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "User Authentication", type: :system do
  describe "user registration" do
    context "when registering as user" do
      it "creates account successfully" do
        visit new_user_registration_path

        fill_in "user_email", with: "user@example.com"
        fill_in "user_password", with: "password123"
        fill_in "user_password_confirmation", with: "password123"

        click_button "Criar Conta"

        expect(page).to have_content("Bem-vindo! Você se registrou com sucesso")
        expect(page).to have_current_path(root_path)
      end
    end

    context "with invalid data" do
      it "shows validation errors" do
        visit new_user_registration_path

        fill_in "user_email", with: "invalid-email"
        fill_in "user_password", with: "123"
        fill_in "user_password_confirmation", with: "456"

        click_button "Criar Conta"

        expect(page).to have_content("erros impediram") || page.has_content?("erro")
      end
    end
  end

  describe "user login" do
    let(:user) { create(:user, email: "user@test.com", password: "password123") }

    context "with valid credentials" do
      it "logs in successfully" do
        visit new_user_session_path

        fill_in "user_email", with: user.email
        fill_in "user_password", with: "password123"

        click_button "Entrar"

        expect(page).to have_content("Login realizado com sucesso")
        expect(page).to have_current_path(root_path)
      end
    end
  end

  describe "user logout" do
    let(:user) { create(:user) }

    it "logs out successfully" do
      login_as(user, scope: :user)
      visit root_path

      click_button "Sair"

      expect(page).to have_content("Logout realizado com sucesso")
      expect(page).to have_link("Entrar")
    end
  end
end
