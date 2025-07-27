# frozen_string_literal: true

Rails.logger.debug "4. Creating Orders..."

client1 = User.find_by!(email: "lucas@cliente.com")
client2 = User.find_by!(email: "maria@cliente.com")

restaurant1 = User.find_by!(email: "pizza@top.com")
restaurant2 = User.find_by!(email: "burger@king.com")

pickup1 = restaurant1.addresses.first
pickup2 = restaurant2.addresses.first

delivery1 = client1.addresses.first
delivery2 = client2.addresses.first

order1 = Order.create!(
  user_id: client1.id,
  pickup_address_id: pickup1.id,
  delivery_address_id: delivery1.id,
  item_description: "1 Pizza Calabresa",
  estimated_value: 39.90,
  payment_method: :cash,
  requested_at: Time.current
)

order2 = Order.create!(
  user_id: client2.id,
  pickup_address_id: pickup2.id,
  delivery_address_id: delivery2.id,
  item_description: "2 Burgers X",
  estimated_value: 39.80,
  payment_method: :card,
  requested_at: Time.current
)

Rails.logger.debug { "Created Order 1 for #{client1.email}: #{order1.item_description}" }
Rails.logger.debug { "Created Order 2 for #{client2.email}: #{order2.item_description}" }
