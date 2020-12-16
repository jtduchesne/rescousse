source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Use Haml templating engine
gem 'haml', '~> 5.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Pagination
gem 'kaminari'
# Form Builder for Bootstrap v4
gem "bootstrap_form", "~> 4.0"

# HTTP client library
gem 'faraday'

# Turbolinks makes following links in your web application faster
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Use RSpec test framework
  gem 'rspec-rails'
  # Use FactoryBot instead of test fixtures
  gem 'factory_bot_rails'
  gem 'faker', require: false
  # Use Webmock to stub HTTP requests in tests
  gem 'webmock', group: :test
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "haml-rails", "~> 2.0"
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end
