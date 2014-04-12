require 'capybara/bootstrap'
require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.configure do |capybara|
  capybara.app_host = 'http://getbootstrap.com/'
  capybara.default_driver = :selenium
  capybara.javascript_driver = :selenium
end

# Update the Firefox path if we're using brew-cask installed firefox
begin
  Selenium::WebDriver::Firefox::Binary.path
rescue Selenium::WebDriver::Error::WebDriverError => web_driver_error
  if Selenium::WebDriver::Platform.os.eql? :macosx
    Selenium::WebDriver::Firefox::Binary.path = File.join(File.readlink(File.expand_path('~/Applications/Firefox.app')), '/Contents/MacOS/firefox-bin')
  else
    raise web_driver_error
  end
end
