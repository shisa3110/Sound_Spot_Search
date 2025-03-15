Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  options.add_argument('window-size=1440,990')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end