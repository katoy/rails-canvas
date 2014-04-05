# -*- coding: utf-8 -*-
source 'https://rubygems.org'

gem 'rails', '~>3.2.14'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'mysql2'
gem 'sqlite3'

# WEBrick でなく thin を使う
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do

  # エラー画面をわかりやすく整形してくれる
  gem 'better_errors'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-doc'

  # better_errorsの画面上にirb/pry(PERL)を表示する
  gem 'binding_of_caller'

  # M + 1 問題のチェック
  gem 'bullet', :group => :development

  # perormance 計測
  gem 'rack-mini-profiler'

  gem 'guard-rspec'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
end

gem "less-rails"
gem 'twitter-bootstrap-rails'

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# for debug, run $ rails s --debugger
gem 'debugger'

group :test do
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'coveralls', require: false

  # テスト自動化用のライブラリ
  gem 'konacha'
  gem 'poltergeist'
  #gem 'capybara-webkit'
  #gem 'headless'
  #gem 'selenium-webdriver'

  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec'
  gem 'rspec-rails', '>= 0', :group => :development
  # gem 'factory_girl_rails', '~> 4.2.1'
  gem 'metric_fu'
end

gem 'devise'
gem 'simple_form'
gem 'best_in_place'
gem 'facebox-rails'
# gem 'google-analytics-rails'
gem 'omniauth-twitter'

gem 'i18n-missing_translations'

gem 'yard', require: false

