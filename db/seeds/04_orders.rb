# frozen_string_literal: true

Rails.logger.debug "4. Creating Orders..."

cliente1 = User.find_by!(email: "lucas@cliente.com")
cliente2 = User.find_by!(email: "maria@cliente.com")

restaurante1 = User.find_by!(email: "pizza@top.com")
restaurante2 = User.find_by!(email: "burger@king.com")

pickup1 = restaurante1.addresses.first
pickup2 = restaurante2.addresses.first

delivery1 = cliente1.addresses.first
delivery2 = cliente2.addresses.first

order1 = Order.create!(
  user_id: cliente1.id,
  pickup_address_id: pickup1.id,
  delivery_address_id: delivery1.id,
  item_description: "1 Pizza Calabresa",
  estimated_value: 39.90,
  payment_method: :cash,
  requested_at: Time.current
)

order2 = Order.create!(
  user_id: cliente2.id,
  pickup_address_id: pickup2.id,
  delivery_address_id: delivery2.id,
  item_description: "2 Burgers X",
  estimated_value: 39.80,
  payment_method: :card,
  requested_at: Time.current
)

Rails.logger.debug { "Created Order 1 for #{cliente1.email}: #{order1.item_description}" }
Rails.logger.debug { "Created Order 2 for #{cliente2.email}: #{order2.item_description}" }
