# frozen_string_literal: true

source "https://rubygems.org"
ruby file: ".ruby-version"

gem "active_model_serializers"
gem "batch_api"
gem "bcrypt", "~> 3.1.7"
gem 'devise', '~> 4.9.0'
gem "devise_token_auth"
gem 'devise-security'
gem "fast_jsonapi", git: "https://github.com/Netflix/fast_jsonapi",
  branch: "dev"
gem "fog-aws"
gem "kaminari"
gem "oj"
gem "paper_trail"
gem "pg", "~> 1.2"
gem "pundit"
gem "rack-cors", require: "rack/cors"
gem "rails", "~> 7.2.2.1"
gem "secure_headers", ">= 7.1.0"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bundler-audit", require: false
  gem "letter_opener_web"
  gem "listen"
  gem "overcommit"
  gem "simplecov", require: false
  gem "spring"
  gem "standard"
  gem "web-console", "~> 4.1"
end

group :development, :test do
  gem "awesome_print"
  gem "brakeman"
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_bot_rails", "~> 6.0"
  gem "faker"
  gem "i18n-tasks", "~> 0.9.6"
  gem "rspec-rails"
end

group :test do
  gem "capybara"
  gem "connection_pool"
  gem "database_cleaner"
  gem "launchy"
  gem "poltergeist"
  gem "pry-rails"
  gem "shoulda-matchers"
  gem "timecop"
end

gem "puma"
