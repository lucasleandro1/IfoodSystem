# frozen_string_literal: true

Rails.logger.debug "1. Creating Users..."

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

@restaurante1 = User.create!(
  email: "pizza@top.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurante2 = User.create!(
  email: "burger@king.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

Rails.logger.debug { "Created cliente 1: #{@cliente1.email}" }
Rails.logger.debug { "Created cliente 2: #{@cliente2.email}" }
Rails.logger.debug { "Created restaurante 1: #{@restaurante1.email}" }
Rails.logger.debug { "Created restaurante 2: #{@restaurante2.email}" }
