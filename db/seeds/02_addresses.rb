# frozen_string_literal: true

Rails.logger.debug "2. Creating Addresses..."

client1 = User.find_by!(email: "lucas@cliente.com")
client2 = User.find_by!(email: "maria@cliente.com")
restaurant1 = User.find_by!(email: "pizza@top.com")
restaurant2 = User.find_by!(email: "burger@king.com")

address1 = Address.create!(
  street: "Rua A", number: "123", neighborhood: "Centro", user_id: client1.id
)

address2 = Address.create!(
  street: "Rua B", number: "456", neighborhood: "Bairro X", user_id: client2.id
)

restaurant_address1 = Address.create!(
  street: "Rua C", number: "789", neighborhood: "Bairro Y", user_id: restaurant1.id
)

restaurant_address2 = Address.create!(
  street: "Rua D", number: "101", neighborhood: "Bairro Z", user_id: restaurant2.id
)

Rails.logger.debug { "Created address for Client 1: #{address1.street}" }
Rails.logger.debug { "Created address for Client 2: #{address2.street}" }
Rails.logger.debug { "Created address for Restaurant 1: #{restaurant_address1.street}" }
Rails.logger.debug { "Created address for Restaurant 2: #{restaurant_address2.street}" }
