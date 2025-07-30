# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end

Capybara.configure do |config|
  config.default_max_wait_time = 5
  config.default_normalize_ws = true

  # Configuração específica para ambiente Docker
  if ENV['RAILS_ENV'] == 'test'
    config.server_host = "0.0.0.0"
    config.server_port = 9887
    config.app_host = "http://127.0.0.1:#{config.server_port}"
  end
end

# Configure allowed hosts in test mode
Capybara.register_driver :test_mode do |app|
  Capybara::RackTest::Driver.new(app, respect_data_method: true)
end
