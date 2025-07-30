# frozen_string_literal: true

Rails.logger.debug "1. Creating Users..."

# Limpar dados existentes em ordem correta
Order.destroy_all
Food.destroy_all
Address.destroy_all
User.destroy_all

# Clientes
@cliente1 = User.create!(
  email: "lucas@cliente.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

@cliente2 = User.create!(
  email: "maria@cliente.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

@cliente3 = User.create!(
  email: "joao@cliente.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

@cliente4 = User.create!(
  email: "ana@cliente.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

@cliente5 = User.create!(
  email: "pedro@cliente.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

@cliente6 = User.create!(
  email: "carla@cliente.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

# Restaurantes
@restaurante1 = User.create!(
  email: "pizzahut@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurante2 = User.create!(
  email: "burgerking@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurante3 = User.create!(
  email: "habibs@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurante4 = User.create!(
  email: "mcdonalds@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurante5 = User.create!(
  email: "subway@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurante6 = User.create!(
  email: "kfc@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurante7 = User.create!(
  email: "bobs@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurante8 = User.create!(
  email: "dominos@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

Rails.logger.debug { "Created #{User.where(role: :cliente).count} clientes" }
Rails.logger.debug { "Created #{User.where(role: :restaurante).count} restaurantes" }
