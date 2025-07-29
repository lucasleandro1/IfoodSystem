# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
  track_files '{app/controllers/**/*.rb,app/models/**/*.rb,app/services/**/*.rb}'

  add_group "Controllers", "app/controllers"
  add_group "Models", "app/models"
  add_group "Services", "app/services"
  add_group "System", "spec/system"

  add_filter "config"
  add_filter "app/channels"
  add_filter "app/jobs"
  add_filter "app/mailers"
  add_filter "app/lib"
  add_filter %r{^/spec/}
  add_filter "app/controllers/application_controller.rb"
end

SimpleCov.at_exit do
  SimpleCov.result.format!
  exit(1) if SimpleCov.result.covered_percent < 100
end
