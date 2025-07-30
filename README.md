# README
# 🍽️ Ifood System

Sistema web de delivery de comida, inspirado no iFood. Desenvolvido em Ruby on Rails com PostgreSQL, utilizando Docker para facilitar o ambiente de desenvolvimento.

---

## 📚 Visão Geral

Este sistema permite que **restaurantes** cadastrem pratos e que **clientees** façam pedidos, selecionando endereço de entrega, método de pagamento e quantidade.

---

## 🧠 Funcionalidades

### 👥 Usuários
- Tipos de usuário: `cliente` e `restaurante`
- Cada um pode ter **um endereço** cadastrado

### 📍 Endereços (`addresses`)
- Campos: rua, número e bairro
- Relacionados a usuários (cliente ou restaurante)

### 🍽️ Pratos (`foods`)
- Criados por restaurantes
- Campos: nome, descrição, preço

### 🛒 Pedidos (`orders`)
- Criados por clientees
- Contêm:
  - Endereço de entrega
  - Endereço de coleta (restaurante)
  - Método de pagamento
  - Quantidade e preço total
  - Status (ex: pedido recebido, em entrega, entregue)

## 🐳 Instruções para Rodar com Docker

### ✅ Pré-requisitos

- Docker
- Docker Compose

### ▶️ Como iniciar o projeto

1. **Clone o repositório**:
 - `git clone https://github.com/lucasleandro1/IfoodSystem.git`
 - `cd ifood_system`

2. **Construa a imagem e suba os containers**:
  - `docker compose build`
  - `docker compose up -d`

3. **Crie e migre o banco de dados**:
  - `docker compose exec web rails db:create`
  - `docker compose exec web bin/rails db:migrate`

4. **(Opcional) Popule com dados iniciais**:
 - `docker compose exec web rails db:seed`

5. Acesse a aplicação:
  - `http://localhost:3000`

## 🧪 Testes

Para rodar os testes:
 - `docker compose run web rspec`

## 🛠️ Tecnologias Utilizadas

- Ruby on Rails
- PostgreSQL
- Docker + Docker Compose
- RSpec
- Devise (para autenticação)

---
Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
