# syntax=docker/dockerfile:1

# Definindo a versão do Ruby que queremos usar
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim

# Definindo o diretório de trabalho para a aplicação
WORKDIR /rails

# Instalando pacotes base necessários para a aplicação
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    sqlite3 \
    nodejs \
    yarn \
    build-essential \
    libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

# Copiar o Gemfile e o Gemfile.lock para a imagem e instalar as dependências do Rails
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copiar o restante da aplicação
COPY . .

# Garantir que as permissões da pasta 'tmp', 'log', 'storage' e 'public' sejam apropriadas para o usuário que executará o Rails
RUN mkdir -p tmp/pids tmp/sockets log storage public && \
    chmod -R 777 tmp log storage public

# Definir a variável de ambiente para o Rails
ENV RAILS_ENV="development"

# Expôr a porta do Rails para o host
EXPOSE 3000

# Comando para rodar o servidor Rails (sem o pré-compilamento dos assets)
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bin/rails s -b '0.0.0.0'"]
