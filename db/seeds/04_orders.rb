# frozen_string_literal: true

Rails.logger.debug "4. Creating Orders..."

# Recuperando clientes
cliente1 = User.find_by!(email: "lucas@cliente.com")
cliente2 = User.find_by!(email: "maria@cliente.com")
cliente3 = User.find_by!(email: "joao@cliente.com")
cliente4 = User.find_by!(email: "ana@cliente.com")
cliente5 = User.find_by!(email: "pedro@cliente.com")
cliente6 = User.find_by!(email: "carla@cliente.com")

# Recuperando restaurantes
restaurante1 = User.find_by!(email: "pizzahut@gmail.com")
restaurante2 = User.find_by!(email: "burgerking@gmail.com")
restaurante3 = User.find_by!(email: "habibs@gmail.com")
restaurante4 = User.find_by!(email: "mcdonalds@gmail.com")
restaurante5 = User.find_by!(email: "subway@gmail.com")
restaurante6 = User.find_by!(email: "kfc@gmail.com")
restaurante7 = User.find_by!(email: "bobs@gmail.com")
restaurante8 = User.find_by!(email: "dominos@gmail.com")

# Recuperando foods
pizza_suprema = Food.find_by!(name: "Pizza Suprema")
pizza_margherita = Food.find_by!(name: "Pizza Margherita")
whopper = Food.find_by!(name: "Whopper")
big_king = Food.find_by!(name: "Big King")
esfiha_carne = Food.find_by!(name: "Esfiha de Carne")
big_mac = Food.find_by!(name: "Big Mac")
quarter_pounder = Food.find_by!(name: "Quarter Pounder")
subway_italiano = Food.find_by!(name: "Subway Italiano BMT")
balde_frango = Food.find_by!(name: "Balde de Frango 8 Pedaços")
hot_wings = Food.find_by!(name: "Hot Wings 6 Unidades")
big_bob = Food.find_by!(name: "Big Bob")
pizza_pepperoni = Food.find_by!(name: "Pizza Pepperoni Tradicional")

# Pedidos variados com diferentes status e datas
# Pedidos recentes (hoje)
Order.create!(
  user_id: cliente1.id,
  food_id: pizza_margherita.id,
  quantity: 1,
  pickup_address_id: restaurante1.addresses.first.id,
  delivery_address_id: cliente1.addresses.first.id,
  item_description: pizza_margherita.name,
  estimated_value: pizza_margherita.price,
  payment_method: :cash,
  requested_at: Time.current - 30.minutes,
  status: :entregue
)

Order.create!(
  user_id: cliente2.id,
  food_id: whopper.id,
  quantity: 2,
  pickup_address_id: restaurante2.addresses.first.id,
  delivery_address_id: cliente2.addresses.first.id,
  item_description: whopper.name,
  estimated_value: whopper.price * 2,
  payment_method: :card,
  requested_at: Time.current - 1.hour,
  status: :preparando
)

Order.create!(
  user_id: cliente3.id,
  food_id: esfiha_carne.id,
  quantity: 1,
  pickup_address_id: restaurante3.addresses.first.id,
  delivery_address_id: cliente3.addresses.first.id,
  item_description: esfiha_carne.name,
  estimated_value: esfiha_carne.price,
  payment_method: :pix,
  requested_at: Time.current - 45.minutes,
  status: :em_rota
)

Order.create!(
  user_id: cliente4.id,
  food_id: big_mac.id,
  quantity: 1,
  pickup_address_id: restaurante4.addresses.first.id,
  delivery_address_id: cliente4.addresses.first.id,
  item_description: big_mac.name,
  estimated_value: big_mac.price,
  payment_method: :card,
  requested_at: Time.current - 20.minutes,
  status: :entregue
)

Order.create!(
  user_id: cliente5.id,
  food_id: subway_italiano.id,
  quantity: 1,
  pickup_address_id: restaurante5.addresses.first.id,
  delivery_address_id: cliente5.addresses.first.id,
  item_description: subway_italiano.name,
  estimated_value: subway_italiano.price,
  payment_method: :cash,
  requested_at: Time.current - 10.minutes,
  status: :pendente
)

# Pedidos de ontem
Order.create!(
  user_id: cliente1.id,
  food_id: balde_frango.id,
  quantity: 2,
  pickup_address_id: restaurante6.addresses.first.id,
  delivery_address_id: cliente1.addresses.first.id,
  item_description: balde_frango.name,
  estimated_value: balde_frango.price * 2,
  payment_method: :pix,
  requested_at: 1.day.ago - 2.hours,
  status: :entregue
)

Order.create!(
  user_id: cliente6.id,
  food_id: big_bob.id,
  quantity: 3,
  pickup_address_id: restaurante7.addresses.first.id,
  delivery_address_id: cliente6.addresses.first.id,
  item_description: big_bob.name,
  estimated_value: big_bob.price * 3,
  payment_method: :card,
  requested_at: 1.day.ago - 3.hours,
  status: :entregue
)

Order.create!(
  user_id: cliente2.id,
  food_id: pizza_pepperoni.id,
  quantity: 1,
  pickup_address_id: restaurante8.addresses.first.id,
  delivery_address_id: cliente2.addresses.first.id,
  item_description: pizza_pepperoni.name,
  estimated_value: pizza_pepperoni.price,
  payment_method: :cash,
  requested_at: 1.day.ago - 1.hour,
  status: :entregue
)

# Pedidos de 2 dias atrás
Order.create!(
  user_id: cliente3.id,
  food_id: pizza_suprema.id,
  quantity: 1,
  pickup_address_id: restaurante1.addresses.first.id,
  delivery_address_id: cliente3.addresses.first.id,
  item_description: pizza_suprema.name,
  estimated_value: pizza_suprema.price,
  payment_method: :pix,
  requested_at: 2.days.ago - 4.hours,
  status: :entregue
)

Order.create!(
  user_id: cliente4.id,
  food_id: big_king.id,
  quantity: 1,
  pickup_address_id: restaurante2.addresses.first.id,
  delivery_address_id: cliente4.addresses.first.id,
  item_description: big_king.name,
  estimated_value: big_king.price,
  payment_method: :card,
  requested_at: 2.days.ago - 6.hours,
  status: :entregue
)

# Pedidos de 3 dias atrás
Order.create!(
  user_id: cliente5.id,
  food_id: quarter_pounder.id,
  quantity: 1,
  pickup_address_id: restaurante4.addresses.first.id,
  delivery_address_id: cliente5.addresses.first.id,
  item_description: quarter_pounder.name,
  estimated_value: quarter_pounder.price,
  payment_method: :cash,
  requested_at: 3.days.ago - 2.hours,
  status: :entregue
)

Order.create!(
  user_id: cliente6.id,
  food_id: hot_wings.id,
  quantity: 3,
  pickup_address_id: restaurante6.addresses.first.id,
  delivery_address_id: cliente6.addresses.first.id,
  item_description: hot_wings.name,
  estimated_value: hot_wings.price * 3,
  payment_method: :pix,
  requested_at: 3.days.ago - 5.hours,
  status: :entregue
)

# Pedidos de uma semana atrás
frango_teriyaki = Food.find_by!(name: "Frango Teriyaki")
combo_bobs = Food.find_by!(name: "Combo Bob's Clássico")
lava_cake = Food.find_by!(name: "Lava Cake Chocolate")

Order.create!(
  user_id: cliente1.id,
  food_id: frango_teriyaki.id,
  quantity: 1,
  pickup_address_id: restaurante5.addresses.first.id,
  delivery_address_id: cliente1.addresses.second.id,
  item_description: frango_teriyaki.name,
  estimated_value: frango_teriyaki.price,
  payment_method: :card,
  requested_at: 1.week.ago - 3.hours,
  status: :entregue
)

Order.create!(
  user_id: cliente2.id,
  food_id: combo_bobs.id,
  quantity: 2,
  pickup_address_id: restaurante7.addresses.first.id,
  delivery_address_id: cliente2.addresses.first.id,
  item_description: combo_bobs.name,
  estimated_value: combo_bobs.price * 2,
  payment_method: :cash,
  requested_at: 1.week.ago - 1.hour,
  status: :entregue
)

Order.create!(
  user_id: cliente3.id,
  food_id: lava_cake.id,
  quantity: 1,
  pickup_address_id: restaurante8.addresses.first.id,
  delivery_address_id: cliente3.addresses.first.id,
  item_description: lava_cake.name,
  estimated_value: lava_cake.price,
  payment_method: :pix,
  requested_at: 1.week.ago - 4.hours,
  status: :entregue
)

# Pedido cancelado
kibe = Food.find_by!(name: "Kibe")

Order.create!(
  user_id: cliente4.id,
  food_id: kibe.id,
  quantity: 1,
  pickup_address_id: restaurante3.addresses.first.id,
  delivery_address_id: cliente4.addresses.first.id,
  item_description: kibe.name,
  estimated_value: kibe.price,
  payment_method: :card,
  requested_at: 2.hours.ago,
  status: :cancelado
)

Rails.logger.debug { "Created #{Order.count} orders total" }
Rails.logger.debug { "Orders by status:" }
Order.group(:status).count.each do |status, count|
  Rails.logger.debug { "  #{status}: #{count}" }
end
