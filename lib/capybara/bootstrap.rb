# Defines the root namespace as Capybara since this gem extends it
module Capybara
  # Defines the {Capybara::Bootstrap} as a namespace
  module Bootstrap; end
end

require 'capybara/bootstrap/version'
require 'capybara/bootstrap/alert'
require 'capybara/bootstrap/base'
require 'capybara/bootstrap/navbar'
