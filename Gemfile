# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'bootsnap', require: false
gem 'coingecko_ruby'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'rails', '~> 7.0.0'
gem 'redis'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'byebug'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webmock'
end
