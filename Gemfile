# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.7', '>= 6.1.7.6'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'dry-struct'
gem 'dry-types'
gem 'jbuilder', '~> 2.7'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'guard-rspec', require: false
  gem 'listen', '~> 3.3'
  gem 'pry-byebug', '~> 3.9'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
