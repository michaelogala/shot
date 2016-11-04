source 'https://rubygems.org'


gem 'rails', '4.2.7.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'imgkit', '~> 1.6', '>= 1.6.1'
gem 'mechanize'
gem 'sidekiq'
gem "browser"
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'active_model_serializers', '~> 0.10.2'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'capybara', '~> 2.9', '>= 2.9.1'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
  gem 'faker', '~> 1.6', '>= 1.6.6'
  gem 'pry-rails', '~> 0.3.4'
end

group :test do
  gem "webmock", group: :test
  gem "poltergeist"
  gem "phantomjs", require: "phantomjs/poltergeist"
  gem "codeclimate-test-reporter", require: nil
  gem "simplecov", require: false
  gem "coveralls", require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'sqlite3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
