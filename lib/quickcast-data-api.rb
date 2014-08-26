require 'sequel'
Sequel.connect(ENV['DATABASE_URL'])
require_relative 'quickcast-data-api/user.rb'