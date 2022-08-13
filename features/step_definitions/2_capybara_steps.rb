Given(/^I visit google using selenium default driver$/) do
  set_up_selenium_default_driver
  visit 'https://www.gov.uk/'
  sleep 5
end

def set_up_selenium_default_driver
  # Capybara pre-registers a number of named drivers that use Selenium - they are:
  # :selenium => Selenium driving Firefox
  # :selenium_headless => Selenium driving Firefox in a headless configuration
  # :selenium_chrome => Selenium driving Chrome
  # :selenium_chrome_headless => Selenium driving Chrome in a headless configuration
  Capybara.default_driver = :selenium
end

Given(/^I visit google using simple capybara$/) do
  set_up_capybara_driver
  visit 'https://www.gov.uk/'
  sleep 5
end

def set_up_capybara_driver
  # Selenium communicates with the chrome web browser
  Capybara.register_driver :john do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  Capybara.default_driver = :john
  Capybara.use_default_driver
end

Given(/^I visit google and pass options to the browser$/) do
  set_up_capybara_driver_with_options
  visit 'https://www.gov.uk/'
  sleep 5
end

def set_up_capybara_driver_with_options
  Capybara.register_driver :john do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument '--start-fullscreen'
    options.add_argument '--window-size=1920,1080'
    options.add_argument '--ignore-certificate-errors'
    Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: [options])
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

  Capybara.register_driver :remote_selenium do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--window-size=1400,1400')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')

    Capybara::Selenium::Driver.new(app, browser: :chrome, url: 'http://localhost:4444', capabilities: options)
  end

  Capybara.default_driver = :remote_selenium
  Capybara.use_default_driver
end

