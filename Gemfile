source "https://rubygems.org"
git_source(:github){|_repo| "https://github.com/#{repo}.git"}

ruby "3.1.2"
gem "bootstrap-sass", "3.4.1"
gem "jbuilder", "~> 2.7"
gem "mysql2", "~> 0.5"
gem "net-imap", require: false
gem "net-pop", require: false
gem "net-smtp", require: false
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.6"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"
gem "config"
gem "bootsnap", ">= 1.4.4", require: false
gem "rails-i18n"

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
group :development, :test do
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end
