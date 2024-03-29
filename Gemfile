source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'rails', '7.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg' # , '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 6'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'bullet'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen' # , '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '>= 2.15'
  # gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  # gem 'webdrivers'
end

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'active_storage_base64'
gem 'acts-as-taggable-on' # , '~> 7.0'
gem 'aws-sdk-s3', require: false
gem 'capistrano' #, '3.10.1'
gem 'capistrano3-nginx', '~> 3.0.4'
gem 'capistrano3-puma', github: "seuros/capistrano-puma"
gem 'capistrano-bundler' #, '1.1.4'
gem 'capistrano-rails' #, '1.1.3'
gem 'capistrano-rvm'
gem 'devise_token_auth', '>= 1.2.0', git: 'https://github.com/lynndylanhurley/devise_token_auth'
gem 'fast_jsonapi'
gem 'friendly_id' # , '~> 5.2.4'
gem 'has_scope'
gem 'kaminari'
gem 'nokogiri'
gem 'rack-cors', require: 'rack/cors'
gem 'rexml'
gem 'textacular', '~> 5.0'

#  for ssh deploy
gem 'bcrypt_pbkdf'
gem 'ed25519'
