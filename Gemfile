source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'materialize-sass', '~> 1.0.0'

gem 'docraptor'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.3.13'
end

group :production, :test do 
  # Use PostGres on heroku
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]



## Add-ons
# Use Stripe for payments
gem 'stripe'
# Use Carriverwave for image uploads, mini-magick to manipulate and fog to retrieve storage
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
#for the QR Code
gem 'rqrcode'
# E-mail processing. Using roadie rather than pre-mailer due to line height/padding issue with the latter
gem 'nokogiri'
gem 'roadie-rails', '~> 1.3.0'

# User authentication
gem 'devise'

# Login service
gem 'omniauth', '~> 1.6.1'
gem 'omniauth-auth0', '~> 2.0.0'

# Persistance for scheduled tasks
gem 'resque', require: 'resque/server'

gem "redis", "~> 3.0" 

gem 'sprockets', '~> 3.7.2'

