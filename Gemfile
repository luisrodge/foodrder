source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'simple_form'
gem 'mini_magick'
gem 'carrierwave', '~> 1.0'
gem 'draper'
gem 'money-rails', '~> 1.7'
gem 'font-awesome-rails'
gem 'searchkick'
gem 'cloudinary'
gem 'rails-assets-sweetalert2', '~> 5.1.1', source: 'https://rails-assets.org'
gem 'sweet-alert2-rails'
gem 'httparty'
gem 'sidekiq'
gem 'cocoon'
gem 'active_model_serializers', '~> 0.10.0'
gem 'kaminari'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem 'recurring_select', github: 'RundownApp/recurring_select'
gem 'momentjs-rails', '>= 2.9.0'
gem 'redis', '~> 3.0'

group :development do
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano-passenger', '~> 0.2.0'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
