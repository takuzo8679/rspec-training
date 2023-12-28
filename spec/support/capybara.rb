RSpec.configure do |config|
  # Capybara.default_max_wait_time = 10

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end
