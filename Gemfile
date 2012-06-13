source 'https://rubygems.org'

gem 'rails', '3.2.3'

group :production, :development do
  gem 'thin'
end

gem 'eventmachine', git: 'https://github.com/eventmachine/eventmachine.git'
gem 'faye', git: 'https://github.com/faye/faye.git'
gem 'momentarily'
gem 'em-synchrony'

gem "rails-backbone"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'pg', :require => 'pg'
gem "mongoid" #, "~> 2.4"
gem "bson_ext", :require => 'bson' #, "~> 1.5"
#gem 'mongoid_fulltext'

# elastic search plugin for mongoid
#gem "mebla", git: 'https://icblenke@github.com/icblenke/mebla.git'

# Pagination
gem 'kaminari'

gem 'twitter-bootstrap-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'underscore-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
