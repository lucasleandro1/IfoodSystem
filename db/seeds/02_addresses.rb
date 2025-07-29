# frozen_string_literal: true

Rails.logger.debug "2. Creating Addresses..."

cliente1 = User.find_by!(email: "lucas@cliente.com")
cliente2 = User.find_by!(email: "maria@cliente.com")
restaurante1 = User.find_by!(email: "pizza@top.com")
restaurante2 = User.find_by!(email: "burger@king.com")

address1 = Address.create!(
  street: "Rua A", number: "123", neighborhood: "Centro", user_id: cliente1.id
)

address2 = Address.create!(
  street: "Rua B", number: "456", neighborhood: "Bairro X", user_id: cliente2.id
)

restaurante_address1 = Address.create!(
  street: "Rua C", number: "789", neighborhood: "Bairro Y", user_id: restaurante1.id
)

restaurante_address2 = Address.create!(
  street: "Rua D", number: "101", neighborhood: "Bairro Z", user_id: restaurante2.id
)

Rails.logger.debug { "Created address for cliente 1: #{address1.street}" }
Rails.logger.debug { "Created address for cliente 2: #{address2.street}" }
Rails.logger.debug { "Created address for restaurante 1: #{restaurante_address1.street}" }
Rails.logger.debug { "Created address for restaurante 2: #{restaurante_address2.street}" }
