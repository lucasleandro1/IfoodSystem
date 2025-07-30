# frozen_string_literal: true

Rails.logger.debug "3. Creating Foods..."

restaurante1 = User.find_by!(email: "pizzahut@gmail.com")
restaurante2 = User.find_by!(email: "burgerking@gmail.com")
restaurante3 = User.find_by!(email: "habibs@gmail.com")
restaurante4 = User.find_by!(email: "mcdonalds@gmail.com")
restaurante5 = User.find_by!(email: "subway@gmail.com")
restaurante6 = User.find_by!(email: "kfc@gmail.com")
restaurante7 = User.find_by!(email: "bobs@gmail.com")
restaurante8 = User.find_by!(email: "dominos@gmail.com")

# Pizza Hut
Food.create!(
  name: "Pizza Suprema",
  description: "Pizza com pepperoni, linguiça, pimentão, cebola e azeitona",
  price: 42.90,
  user_id: restaurante1.id
)

Food.create!(
  name: "Pizza Margherita",
  description: "Pizza com molho de tomate, mussarela e manjericão fresco",
  price: 35.90,
  user_id: restaurante1.id
)

Food.create!(
  name: "Pizza Pepperoni",
  description: "Pizza tradicional com generosa cobertura de pepperoni",
  price: 38.90,
  user_id: restaurante1.id
)

Food.create!(
  name: "Pizza 4 Queijos",
  description: "Pizza com mussarela, catupiry, parmesão e provolone",
  price: 45.90,
  user_id: restaurante1.id
)

# Burger King
Food.create!(
  name: "Whopper",
  description: "O clássico Whopper com carne grelhada, alface, tomate e maionese",
  price: 28.90,
  user_id: restaurante2.id
)

Food.create!(
  name: "Big King",
  description: "Dois hambúrgueres, queijo, alface, cebola e molho especial",
  price: 26.90,
  user_id: restaurante2.id
)

Food.create!(
  name: "Whopper Jr",
  description: "Versão menor do Whopper com todos os ingredientes originais",
  price: 19.90,
  user_id: restaurante2.id
)

Food.create!(
  name: "Onion Rings",
  description: "Anéis de cebola empanados e crocantes",
  price: 12.90,
  user_id: restaurante2.id
)

# Habib's
Food.create!(
  name: "Esfiha de Carne",
  description: "Esfiha tradicional com carne temperada e especiarias árabes",
  price: 8.90,
  user_id: restaurante3.id
)

Food.create!(
  name: "Kibe",
  description: "Kibe frito crocante com recheio de carne e trigo",
  price: 6.90,
  user_id: restaurante3.id
)

Food.create!(
  name: "Combo Beirute",
  description: "Beirute de carne com batata frita e refrigerante",
  price: 22.90,
  user_id: restaurante3.id
)

Food.create!(
  name: "Esfirra de Queijo",
  description: "Esfirra aberta com queijo derretido e temperos especiais",
  price: 7.90,
  user_id: restaurante3.id
)

# McDonald's
Food.create!(
  name: "Big Mac",
  description: "Dois hambúrgueres, alface, queijo, molho especial, cebola e pepino",
  price: 24.90,
  user_id: restaurante4.id
)

Food.create!(
  name: "Quarter Pounder",
  description: "Hambúrguer de carne bovina com queijo, cebola e molho ketchup",
  price: 26.90,
  user_id: restaurante4.id
)

Food.create!(
  name: "McNuggets",
  description: "10 pedaços de nuggets de frango crocantes",
  price: 18.90,
  user_id: restaurante4.id
)

Food.create!(
  name: "McFritas Grande",
  description: "Batata frita dourada e crocante no tamanho grande",
  price: 14.90,
  user_id: restaurante4.id
)

# Subway
Food.create!(
  name: "Subway Italiano BMT",
  description: "Sanduíche com pepperoni, salame, presunto, queijo e vegetais",
  price: 22.90,
  user_id: restaurante5.id
)

Food.create!(
  name: "Frango Teriyaki",
  description: "Sanduíche com frango grelhado ao molho teriyaki e vegetais",
  price: 20.90,
  user_id: restaurante5.id
)

Food.create!(
  name: "Subway Melt",
  description: "Sanduíche com peru, presunto, bacon e queijo derretido",
  price: 24.90,
  user_id: restaurante5.id
)

Food.create!(
  name: "Cookies Duplo Chocolate",
  description: "3 cookies de chocolate com gotas de chocolate",
  price: 8.90,
  user_id: restaurante5.id
)

# KFC
Food.create!(
  name: "Balde de Frango 8 Pedaços",
  description: "8 pedaços de frango crocante com tempero secreto do Coronel",
  price: 42.90,
  user_id: restaurante6.id
)

Food.create!(
  name: "Hot Wings 6 Unidades",
  description: "6 asinhas de frango picantes e crocantes",
  price: 18.90,
  user_id: restaurante6.id
)

Food.create!(
  name: "Zinger Burger",
  description: "Sanduíche de frango empanado picante com maionese",
  price: 22.90,
  user_id: restaurante6.id
)

Food.create!(
  name: "Batata Palito Tempero KFC",
  description: "Batata frita com o tempero especial KFC",
  price: 12.90,
  user_id: restaurante6.id
)

# Bob's
Food.create!(
  name: "Big Bob",
  description: "Hambúrguer duplo com queijo, alface, tomate e molho especial",
  price: 25.90,
  user_id: restaurante7.id
)

Food.create!(
  name: "Milkshake Ovomaltine",
  description: "Milkshake cremoso sabor Ovomaltine com chantilly",
  price: 14.90,
  user_id: restaurante7.id
)

Food.create!(
  name: "Combo Bob's Clássico",
  description: "Hambúrguer, batata frita e refrigerante",
  price: 22.90,
  user_id: restaurante7.id
)

Food.create!(
  name: "Batata Recheada",
  description: "Batata frita com cheddar, bacon e cebolinha",
  price: 16.90,
  user_id: restaurante7.id
)

# Domino's Pizza
Food.create!(
  name: "Pizza Pepperoni Tradicional",
  description: "Pizza com generosa cobertura de pepperoni e queijo mussarela",
  price: 35.90,
  user_id: restaurante8.id
)

Food.create!(
  name: "Pizza Frango Catupiry",
  description: "Pizza com frango desfiado e catupiry cremoso",
  price: 38.90,
  user_id: restaurante8.id
)

Food.create!(
  name: "Pão de Alho Recheado",
  description: "Pão de alho com queijo mussarela derretido por dentro",
  price: 16.90,
  user_id: restaurante8.id
)

Food.create!(
  name: "Lava Cake Chocolate",
  description: "Bolinho quente de chocolate com recheio derretido",
  price: 12.90,
  user_id: restaurante8.id
)

Food.create!(
  name: "Pizza Margherita Artesanal",
  description: "Pizza com molho de tomate, mussarela de búfala e manjericão",
  price: 42.90,
  user_id: restaurante8.id
)

Rails.logger.debug { "Created #{Food.count} foods total across #{User.where(role: :restaurante).count} restaurants" }
