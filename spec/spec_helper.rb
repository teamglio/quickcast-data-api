require 'rspec'
require 'rack/test'
require 'awesome_print'
RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end

require_relative '../models/models.rb'
require_relative '../controllers/controllers.rb'