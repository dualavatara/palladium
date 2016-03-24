source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'

# MongoDB
gem 'mongoid', '~> 5.1.0'
gem 'bson_ext'
gem 'mongoid_rails_migrations'
gem 'mongoid_paranoia'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'email_validator'
gem 'valid_url'
gem 'bootstrap-sass'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'dotenv-rails'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  gem 'test-unit'
  gem 'factory_girl_rails'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'database_cleaner', :git => 'https://github.com/DatabaseCleaner/database_cleaner.git'
  gem "show_me_the_cookies"
end


group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  #gem 'linecache'
  #gem 'ruby-debug-base'
  #gem 'linecache19', '>= 0.5.13', :git => 'https://github.com/robmathews/linecache19-0.5.13.git'
  #gem 'ruby-debug-ide'
end

