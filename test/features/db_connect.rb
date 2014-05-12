require 'database_cleaner'
require 'active_record'

DatabaseCleaner.strategy = :truncation

connect_to_db = lambda do 
	if ENV['RUBY_ENV'] == 'PRODUCTION'
		env_type = 'production'
	else
		env_type = 'development'
	end
  	ActiveRecord::Base.establish_connection YAML.load_file('../config/database.yml')[env_type]
  	ActiveRecord::Base.logger = Logger.new(File.open('../logs/db.log', 'a'))
end
connect_to_db.call

Before() do
	DatabaseCleaner.clean
	User.create_test_admin_user
	User.create_test_normal_user
	Vtsmovement.create_test_data
end