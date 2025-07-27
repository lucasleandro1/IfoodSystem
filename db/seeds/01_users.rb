# frozen_string_literal: true

Rails.logger.debug "1. Creating Users..."

@client1 = User.create!(
  email: "lucas@cliente.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

@client2 = User.create!(
  email: "maria@cliente.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

@restaurant1 = User.create!(
  email: "pizza@top.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

@restaurant2 = User.create!(
  email: "burger@king.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1
)

Rails.logger.debug { "Created Client 1: #{@client1.email}" }
Rails.logger.debug { "Created Client 2: #{@client2.email}" }
Rails.logger.debug { "Created Restaurant 1: #{@restaurant1.email}" }
Rails.logger.debug { "Created Restaurant 2: #{@restaurant2.email}" }
