require 'rspec'
require 'rack/test'
require 'awesome_print'
require 'database_cleaner'

require_relative '../models/user.rb'
require_relative '../models/app.rb'
require_relative '../models/activation_request.rb'

require_relative '../endpoints/application_endpoints.rb'
require_relative '../endpoints/activation_attempt_endpoints.rb'
require_relative '../endpoints/user_endpoints.rb'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  DatabaseCleaner[:sequel, {:connection => Sequel.connect(ENV['DATABASE_URL'])}].strategy = :truncation
end