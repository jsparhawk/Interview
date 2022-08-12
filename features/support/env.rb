# frozen_string_literal: true

require 'date'
require 'rspec'
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'webdrivers'
require 'capybara'

# docker-compose up to start a container which can be accessed on localhost:4444 - password secret
# when you run the test selenium_image.feature it will visit a site and wait for 50 seconds
# you can see the site on localhost:4444

Capybara.register_driver :remote_selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--window-size=1400,1400')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')

  Capybara::Selenium::Driver.new(app, browser: :chrome, url: 'http://localhost:4444', capabilities: options)
end

Capybara.default_driver = :remote_selenium
Capybara.use_default_driver
