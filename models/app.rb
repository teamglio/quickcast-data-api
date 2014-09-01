require 'sequel'
Sequel.connect(ENV['DATABASE_URL'])

class App < Sequel::Model
  plugin :timestamps
  plugin :validation_helpers
  plugin :secure_password
  def validate
    super
    validates_presence :client_id
    validates_unique :client_id
  end

  many_to_one :user
end