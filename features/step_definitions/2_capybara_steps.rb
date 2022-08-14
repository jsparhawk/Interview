Given(/^I visit google using capybara selenium default driver$/) do
  set_up_capybara_selenium_default_driver
  visit 'https://www.gov.uk/'
  sleep 5
end

def set_up_capybara_selenium_default_driver
  # Capybara pre-registers a number of named drivers that use Selenium - they are:
  # :selenium => Selenium driving Firefox
  # :selenium_headless => Selenium driving Firefox in a headless configuration
  # :selenium_chrome => Selenium driving Chrome
  # :selenium_chrome_headless => Selenium driving Chrome in a headless configuration
  Capybara.default_driver = :selenium
end

Given(/^I visit google registering a selenium driver to capybara$/) do
  register_a_selenium_driver_to_capybara
  visit 'https://www.gov.uk/'
  sleep 5
end

def register_a_selenium_driver_to_capybara
  # Register a selenium driver to capybara
  Capybara.register_driver :john do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.default_driver = :john
end

Given(/^I visit google using remote selenium$/) do
  set_up_capybara_remote_driver
  visit 'https://www.gov.uk/'
  sleep 50
end

def set_up_capybara_remote_driver
  # docker-compose up to start a container which can be accessed on localhost:4444 - password secret
  # when you run the test selenium_image.feature it will visit a site and wait for 50 seconds
  # you can see the site on localhost:4444
  Capybara.register_driver :remote_john do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome, url: 'http://localhost:4444')
  end
  Capybara.default_driver = :remote_john
end

Given(/^I visit google using selenium$/) do
  driver = set_up_selenium_driver
  driver.navigate.to 'https://www.gov.uk/'
  sleep 5
end

def set_up_selenium_driver
  # Selenium communicates with the chrome web browser
  Selenium::WebDriver.for :chrome
end

Given(/^I visit google using selenium and pass options to a browser$/) do
  driver = set_up_selenium_driver_with_options
  driver.navigate.to 'https://www.gov.uk/'
  sleep 5
end

def set_up_selenium_driver_with_options
  # Selenium allows you to pass options to change chrome
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--ignore-certificate-errors')
  options.add_argument('--disable-popup-blocking')
  options.add_argument('--disable-translate')
  Selenium::WebDriver.for :chrome, options: options
end

Given(/^I visit google using selenium and pass preferences to a browser$/) do
  driver = set_up_selenium_driver_with_preferences
  driver.navigate.to 'https://www.gov.uk/'
  sleep 5
end

def set_up_selenium_driver_with_preferences
  # Selenium allows you to pass preferences to change chrome
  prefs = {
    prompt_for_download: false,
    default_directory: '/path/to/dir',
  }
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_preference(:download, prefs)
  Selenium::WebDriver.for :chrome, options: options
end

Given(/^I visit google using capybara and pass options to the browser$/) do
  set_up_capybara_driver_with_options
  visit 'https://www.gov.uk/'
  sleep 5
end

def set_up_capybara_driver_with_options
  # Capybara registers a selenium driver
  # Selenium communicates with the chrome browser passing the options to chrome
  Capybara.register_driver :john do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument '--start-fullscreen'
    options.add_argument '--window-size=1920,1080'
    options.add_argument '--ignore-certificate-errors'
    puts options.inspect
    Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: [options])
  end
  Capybara.default_driver = :john
end

Given(/^I visit google and see logging info$/) do
  driver = set_up_selenium_driver_with_logging
  driver.navigate.to 'https://www.gov.uk/'
  sleep 5
end

def set_up_selenium_driver_with_logging
  # Output Selenium logging :info :debug etc
  Selenium::WebDriver.logger.level = :debug
  Selenium::WebDriver.for :chrome
end