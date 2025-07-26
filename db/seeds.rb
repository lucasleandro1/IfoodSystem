# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Criação de usuários (clientes e restaurantes)

# Criando usuários "clientes"
client1 = User.create!(email: "lucas@cliente.com", password: "123456", role: :client)
client2 = User.create!(email: "maria@cliente.com", password: "123456", role: :client)

# Criando usuários "restaurantes"
restaurant1 = User.create!(email: "pizza@top.com", password: "123456", role: :restaurant)
restaurant2 = User.create!(email: "burger@king.com", password: "123456", role: :restaurant)

# Criando endereços
address1 = Address.create!(street: "Rua A", number: "123", neighborhood: "Centro", user: client1)
address2 = Address.create!(street: "Rua B", number: "456", neighborhood: "Bairro X", user: client2)

# Restaurantes criam endereços
restaurant_address1 = Address.create!(street: "Rua C", number: "789", neighborhood: "Bairro Y", user: restaurant1)
restaurant_address2 = Address.create!(street: "Rua D", number: "101", neighborhood: "Bairro Z", user: restaurant2)

# Criando produtos (para restaurantes)
pizza = Product.create!(name: "Pizza Calabresa", description: "Pizza com calabresa", price: 39.90, user: restaurant1)
burger = Product.create!(name: "Burger X", description: "Burger com carne e queijo", price: 19.90, user: restaurant2)

# Criando pedidos para clientes
order1 = Order.create!(user: client1, pickup_address: restaurant_address1, delivery_address: address1, item_description: "1 Pizza Calabresa", estimated_value: 39.90, payment_method: :cash, requested_at: Time.now)
order2 = Order.create!(user: client2, pickup_address: restaurant_address2, delivery_address: address2, item_description: "2 Burgers X", estimated_value: 39.80, payment_method: :card, requested_at: Time.now)

# Associando produtos aos pedidos
OrderProduct.create!(order: order1, product: pizza, quantity: 1, unit_price: 39.90)
OrderProduct.create!(order: order2, product: burger, quantity: 2, unit_price: 19.90)
