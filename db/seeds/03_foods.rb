# frozen_string_literal: true

Rails.logger.debug "3. Creating Foods..."

restaurante1 = User.find_by!(email: "pizza@top.com")
restaurante2 = User.find_by!(email: "burger@king.com")

pizza = Food.create!(
  name: "Pizza Calabresa",
  description: "Pizza com calabresa",
  price: 39.90,
  user_id: restaurante1.id
)

burger = Food.create!(
  name: "Burger X",
  description: "Burger com carne e queijo",
  price: 19.90,
  user_id: restaurante2.id
)

Rails.logger.debug { "Created Food: #{pizza.name} (#{pizza.user.email})" }
Rails.logger.debug { "Created Food: #{burger.name} (#{burger.user.email})" }
