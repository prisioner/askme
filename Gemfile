source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.7.5'

gem 'rails', '~> 5.2.6'
gem 'puma', '~> 5.6.2'
gem 'uglifier'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'slim-rails'
gem 'rails-i18n', '~> 5.0.0'
gem 'strip_attributes'
gem 'rails_12factor'
gem 'jqcloud-rails'
gem 'pg'
gem 'pg_search'
gem 'geocoder'
gem 'recaptcha', require: 'recaptcha/rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
