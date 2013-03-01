source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end


gem 'twitter-bootstrap-rails'
gem "less-rails"
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'
gem 'bootstrap-editable-rails'

gem 'devise'
gem 'devise-i18n'
gem 'omniauth-facebook', '1.4.0'
gem 'cancan'
gem 'rolify'
gem 'activeadmin'
gem 'thinking-sphinx'
gem 'simple-navigation'
gem 'acts_as_tree'
# gem 'activerecord-postgres-array'
gem 'ar_pg_array'

gem 'rails_config'
gem 'newrelic_rpm'
gem 'airbrake'
gem 'simple_form'
gem 'nested_form'
gem 'flash_messages_helper'
gem 'rmagick'
gem 'carrierwave'
gem 'state_machine'
gem 'validates_timeliness'

gem 'kaminari'
gem 'acts-as-taggable-on'

gem 'rails-i18n'
gem 'whenever', :require => false

gem 'inherited_resources'
gem 'friendly_id'
gem 'has_scope'

gem 'meta-tags', :require => 'meta_tags'
gem 'gravatar_image_tag'
gem 'client_side_validations'

group :development do
  gem 'quiet_assets'
  gem 'awesome_print'
  gem 'seed-fu'
  gem 'erb2haml'
  gem 'letter_opener'
  gem 'rails_best_practices'
  gem 'rails-footnotes', '>= 3.7.5.rc4'

  gem 'mechanize', require: false # frilancim.ru grabber

  gem 'pry'
  

  ### Guard
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-migrate'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rb-fsevent', require: false
  gem 'ruby_gntp',  require: false
end

group :test, :development do
  gem 'spork', '> 0.9.0.rc'
  gem 'rspec', '>= 2.6.0'
  gem 'rspec-rails', '>= 2.6.0'
  gem 'factory_girl_rails'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'ffaker'
  # gem 'parallel_tests' # https://github.com/grosser/parallel_tests
  # gem 'test-unit'
  # gem 'rr'
end