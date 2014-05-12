if RUBY_VERSION > "1.9"
  require 'simplecov'
  SimpleCov.start 
  SimpleCov.coverage_dir 'coverage/cuke'
end

require 'rubygems'
require 'active_record'
require 'database_cleaner'
require 'mysql2'
require 'rspec-expectations'
require 'factory_girl'
require 'debugger'
require 'page-object'
require 'page-object/page_factory'
require 'faker'
require 'data_magic'

require_relative 'db_connect'
require '../model/user'
require '../model/vtsmovement'
require '../model/registrationcode'
require './data/page_data'
require '../helpers/helpers'

Faker::Config.locale = "en-gb"
World(PageObject::PageFactory, PageHelper)