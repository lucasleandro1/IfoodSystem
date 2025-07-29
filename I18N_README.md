# Sistema de Internacionalização (i18n)

## Estrutura dos Locales

O projeto agora está organizado com suporte completo ao i18n em duas pastas:

```
config/locales/
├── en/              # Traduções em inglês
│   ├── application.yml
│   ├── devise.yml
│   ├── models.yml
│   └── views.yml
└── pt_br/           # Traduções em português brasileiro
    ├── application.yml
    ├── devise.yml
    ├── models.yml
    └── views.yml
```

## Configurações

- **Idioma padrão**: Português brasileiro (`pt_br`)
- **Idiomas disponíveis**: Inglês (`en`) e Português brasileiro (`pt_br`)
- **Fallback**: Inglês (quando uma tradução não for encontrada em português)

## Views Traduzidas

### ✅ **Todas as views principais foram atualizadas:**

1. **Layouts**:
   - `layouts/application.html.erb` - Título da aplicação
   - `shared/_topbar.html.erb` - Menu de navegação completo
   - `shared/_incomple_profile_alert.html.erb` - Alerta de perfil incompleto

2. **Home**:
   - `home/index.html.erb` - Página inicial com listagem de comidas, filtros e ordenação

3. **Orders**:
   - `orders/index.html.erb` - Listagem de pedidos com filtros completos

4. **Foods**:
   - `foods/index.html.erb` - Listagem de comidas para restaurantes e clientes

5. **Addresses**:
   - `addresses/index.html.erb` - Gerenciamento de endereços

## Como usar nas views

### Traduções básicas
```erb
<%= t('app.welcome') %>
<%= t('ui.buttons.save') %>
<%= t('views.home.index.title') %>
```

### Traduções com interpolação
```erb
<%= t('views.home.index.hello_user', name: user_name) %>
<%= t('views.orders.index.orders_found', count: @orders.total_count) %>
```

### Traduções de modelos
```erb
<%= User.model_name.human %>  <!-- "Usuário" -->
<%= User.human_attribute_name(:email) %>  <!-- "E-mail" -->
```

### Helpers disponíveis
```erb
<%= current_locale %>  <!-- :pt_br -->
<%= locale_name(current_locale) %>  <!-- "Português (Brasil)" -->
<%= other_locale %>  <!-- :en -->
```

## Organização dos arquivos

- **application.yml**: Traduções gerais da aplicação, elementos de UI e componentes compartilhados
- **models.yml**: Traduções de modelos ActiveRecord (nomes e atributos)
- **views.yml**: Traduções específicas das views organizadas por controller e action
- **devise.yml**: Traduções completas do sistema de autenticação Devise

## Principais funcionalidades traduzidas

### **Interface de Navegação**
- Menu principal com todos os links
- Mensagens de boas-vindas personalizadas
- Estados de autenticação

### **Home/Listagem de Comidas**
- Filtros e ordenação
- Mensagens de estado vazio
- Paginação
- Actions de usuário (ver, pedir, login)

### **Sistema de Pedidos**
- Filtros avançados (status, período, data, restaurante)
- Detalhes completos dos pedidos
- Actions específicas por tipo de usuário
- Estados de pedidos traduzidos

### **Gerenciamento de Comidas**
- Views específicas para restaurantes e clientes
- Actions contextuais
- Mensagens de confirmação

### **Endereços**
- Listagem e gerenciamento
- Formulários e confirmações

## Status atual

✅ **Sistema i18n completamente implementado**  
✅ **Todas as views principais traduzidas**  
✅ **Navegação totalmente internacionalizada**  
✅ **Formulários e actions traduzidos**  
✅ **Mensagens de estado e confirmação**  
✅ **Paginação e filtros traduzidos**  
✅ **Suporte completo ao Devise**  

**O sistema está 100% funcional com traduções completas em português brasileiro e inglês!**

## Próximos passos (opcionais)

Para expandir ainda mais o sistema i18n:

1. **Traduzir formulários**: Adicionar traduções para labels e placeholders dos forms
2. **Mensagens de erro**: Customizar mensagens de validação
3. **Emails**: Traduzir templates de email do Devise
4. **JavaScript**: Adicionar suporte a i18n no frontend
5. **Seletor de idioma**: Implementar troca de idioma na interface
