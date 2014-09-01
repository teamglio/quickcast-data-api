require 'sequel'
Sequel.connect(ENV['DATABASE_URL'])

class ActivationRequest < Sequel::Model
  plugin :validation_helpers
  plugin :timestamps

  def validate
    super
    validates_presence :user_id
  end

  many_to_one :user
end