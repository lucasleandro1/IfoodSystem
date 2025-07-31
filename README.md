# README
# Ifood System

Sistema web de delivery de comida, inspirado no iFood. Desenvolvido em Ruby on Rails, utilizando Docker para facilitar o ambiente de desenvolvimento.

---

## Visão Geral

Este sistema permite que **restaurantes** cadastrem pratos e que **clientes** façam pedidos, selecionando endereço de entrega, método de pagamento e quantidade.

---

## Funcionalidades

### Usuários
- Tipos de usuário: `cliente` e `restaurante`
- Cada um pode ter **endereços** cadastrado

### Endereços (`addresses`)
- Campos: rua, número e bairro
- Relacionados a usuários (cliente ou restaurante)

### Pratos (`foods`)
- Criados por restaurantes
- Campos: nome, descrição, preço

### Pedidos (`orders`)
- Criados por clientes
- Contêm:
  - Endereço de entrega(cliente)
  - Endereço de coleta (restaurante)
  - Método de pagamento
  - Quantidade e preço total
  - Status (ex: pedido recebido, em entrega, entregue)

## Instruções para Rodar com Docker

### Pré-requisitos

- Docker
- Docker Compose

### Como iniciar o projeto

1. **Clone o repositório**:
  - `git clone https://github.com/lucasleandro1/IfoodSystem.git`
  - `cd ifood_system`

2. **Construir e subir os containers**:
  - `docker compose build`
  - `docker compose up -d`

4. **Criar e migrar o banco de dados**:
  - `docker compose exec web bin/rails db:create db:migrate`

5. **(Opcional) Popular banco de dados**:
  - `docker compose exec web rails db:seed`

6. **Acessar a aplicação**:
   - `http://localhost:3000`

## Testes

Para rodar os testes:
  - `./bin/docker-test`

## Tecnologias Utilizadas

- Ruby on Rails
- Docker + Docker Compose
- RSpec (testes)
- Devise (para autenticação)
- Kaminari (para paginação)
- Ransack (para filtros)