# frozen_string_literal: true

Rails.logger.debug "2. Creating Addresses..."

# Endereços dos clientes
cliente1 = User.find_by!(email: "lucas@cliente.com")
cliente2 = User.find_by!(email: "maria@cliente.com")
cliente3 = User.find_by!(email: "joao@cliente.com")
cliente4 = User.find_by!(email: "ana@cliente.com")
cliente5 = User.find_by!(email: "pedro@cliente.com")
cliente6 = User.find_by!(email: "carla@cliente.com")

# Endereços dos restaurantes
restaurante1 = User.find_by!(email: "pizzahut@gmail.com")
restaurante2 = User.find_by!(email: "burgerking@gmail.com")
restaurante3 = User.find_by!(email: "habibs@gmail.com")
restaurante4 = User.find_by!(email: "mcdonalds@gmail.com")
restaurante5 = User.find_by!(email: "subway@gmail.com")
restaurante6 = User.find_by!(email: "kfc@gmail.com")
restaurante7 = User.find_by!(email: "bobs@gmail.com")
restaurante8 = User.find_by!(email: "dominos@gmail.com")

# Criando endereços para clientes
Address.create!(
  street: "Rua das Flores", number: "123", neighborhood: "Centro", user_id: cliente1.id
)

Address.create!(
  street: "Av. Paulista", number: "1500", neighborhood: "Bela Vista", user_id: cliente1.id
)

Address.create!(
  street: "Rua Augusta", number: "456", neighborhood: "Consolação", user_id: cliente2.id
)

Address.create!(
  street: "Rua Oscar Freire", number: "789", neighborhood: "Jardins", user_id: cliente3.id
)

Address.create!(
  street: "Av. Brigadeiro Faria Lima", number: "1000", neighborhood: "Itaim Bibi", user_id: cliente4.id
)

Address.create!(
  street: "Rua 25 de Março", number: "555", neighborhood: "Sé", user_id: cliente5.id
)

Address.create!(
  street: "Av. Rebouças", number: "2200", neighborhood: "Pinheiros", user_id: cliente6.id
)

# Criando endereços para restaurantes
Address.create!(
  street: "Av. Paulista", number: "1578", neighborhood: "Bela Vista", user_id: restaurante1.id
)

Address.create!(
  street: "Rua Augusta", number: "2690", neighborhood: "Jardins", user_id: restaurante2.id
)

Address.create!(
  street: "Rua da Liberdade", number: "150", neighborhood: "Liberdade", user_id: restaurante3.id
)

Address.create!(
  street: "Av. Faria Lima", number: "3064", neighborhood: "Itaim Bibi", user_id: restaurante4.id
)

Address.create!(
  street: "Rua Oscar Freire", number: "909", neighborhood: "Jardins", user_id: restaurante5.id
)

Address.create!(
  street: "Av. Rebouças", number: "3970", neighborhood: "Pinheiros", user_id: restaurante6.id
)

Address.create!(
  street: "Rua 25 de Março", number: "1020", neighborhood: "Centro", user_id: restaurante7.id
)

Address.create!(
  street: "Av. Ibirapuera", number: "2332", neighborhood: "Moema", user_id: restaurante8.id
)

Rails.logger.debug { "Created #{Address.count} addresses total" }
