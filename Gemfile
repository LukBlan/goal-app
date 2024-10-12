source "https://rubygems.org"

ruby "3.3.5"

gem "rails", "~> 7.1.4"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails', '~> 7.0', '>= 7.0.1'
end

group :development do
  gem "web-console"
  gem "binding_of_caller"
  gem "better_errors"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "factory_bot_rails"
  gem "faker"
  gem "rails-controller-testing"
end

gem 'psych', '~> 4.0', '>= 4.0.6'