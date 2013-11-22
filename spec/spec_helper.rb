# encoding: utf-8
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rspec/rails"
require 'rspec/autorun'
require 'mocha/api'
#require 'database_cleaner'
require 'pry'

Rails.backtrace_cleaner.remove_silencers!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
  #config.use_transactional_fixtures = false
  #config.include FactoryGirl::Syntax::Methods

  #config.before(:suite) do
    #DatabaseCleaner.strategy = :transaction
    #DatabaseCleaner.clean_with :truncation, { :pre_count => true }
  #end

  #config.before(:each) do
    #DatabaseCleaner.start
  #end

  #config.after(:each) do
    #DatabaseCleaner.clean
  #end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Disable should syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
