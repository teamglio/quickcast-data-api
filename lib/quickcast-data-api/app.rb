require 'sequel'

class App < Sequel::Model
  plugin :secure_password
  plugin :validation_helpers
  def validate
    super
    validates_presence :client_id
    validates_unique :client_id
  end

  many_to_one :user
end