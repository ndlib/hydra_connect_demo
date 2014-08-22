source 'https://rubygems.org'
ruby '2.1.2'
gem 'rails', '4.1.4'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'high_voltage'

gem 'hydramata-core', github: 'ndlib/hydramata-core', branch: 'master'
gem 'hydramata-works', github: 'ndlib/hydramata-works', branch: 'master'

group :development do
  if ! ENV['TRAVIS']
    gem 'binding_of_caller', :platforms=>[:mri_21]
    gem 'guard-bundler'
    gem 'guard-rails'
    gem 'guard-rspec'
    gem 'rb-fchange', :require=>false
    gem 'rb-fsevent', :require=>false
    gem 'rb-inotify', :require=>false
    gem 'byebug'
    gem 'better_errors'
    gem 'quiet_assets'
    gem 'yard'
    gem 'capistrano', '~> 3.0.1'
    gem 'capistrano-bundler'
    gem 'capistrano-rails', '~> 1.1.0'
    gem 'capistrano-rails-console'
    gem 'capistrano-rvm', '~> 0.1.1'
  end
  gem 'foreman'
  gem 'rails_layout'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'rspec-given'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end
