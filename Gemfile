source 'https://rubygems.org'

gem 'rails', '4.2.6'

# Env variables (must be at top)
gem 'dotenv-rails', '~> 2.0.1', group: [:development, :test]

# Database
gem 'sqlite3'

# Authentication
gem 'devise'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-ui-rails', '~> 4.1.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Add location data to models
gem 'geocoder', '~> 1.3.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "factory_girl_rails", "~> 4.0"
  gem "faker", "~> 1.6.3"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Use RSpec for tests
  gem 'rspec-rails', '~> 3.4'

  # Add extra RSpec matchers for validations, etc.
  gem 'shoulda-matchers', '~> 3.1'

  # Use capybara for feature specs
  gem 'capybara'

  # Use phantomjs for js features
  gem 'poltergeist', '~> 1.8.1'

  # Control database behavior across test processes
  gem 'database_cleaner', '~> 1.2.0'
end

# Gems installed outside Gemfile
# foreman
# mailcatcher
