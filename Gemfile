source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 7.0.3'

gem 'acts_as_list', '~> 1.0', '>= 1.0.4'

gem 'aws-sdk-s3', '~> 1.112'

gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb

gem 'bootsnap', require: false

gem 'fast_jsonapi', '~> 1.1', '>= 1.1.1'

gem 'lefthook', '~> 0.7.7'

# For secure mime-type determination

gem 'marcel', '~> 1.0.2'

gem 'puma', '~> 5.0'

gem 'pg', '~> 1.1'

gem 'rack-cors', '~> 1.1', '>= 1.1.1'

gem 'rspec-rails', '~> 6.0.0.rc1'

gem 'rswag', '~> 2.5'

gem 'strong_migrations', '~> 0.8.0'

gem 'shrine', '~> 3.4'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'brakeman', '~> 5.2'
  gem 'bullet', '~> 7.0'
  gem 'bundler-audit', '~> 0.9.0'
  gem 'bundler-leak', '~> 0.2.0'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dry-schema', '~> 1.9', '>= 1.9.3'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'ffaker', '~> 2.21'
  gem 'rswag-specs', '~> 2.5', '>= 2.5.1'
  gem 'rubocop', '~> 1.25'
  gem 'rubocop-performance', '~> 1.13'
  gem 'rubocop-rails', '~> 2.13'
  gem 'rubocop-rspec', '~> 2.8'
  gem 'seedbank', '~> 0.5.0'
  gem 'traceroute', '~> 0.8.1'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'json_matchers', '~> 0.11.1'
  gem 'rails-controller-testing', '~> 1.0.1'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'simplecov', '~> 0.21.2', require: false
end
