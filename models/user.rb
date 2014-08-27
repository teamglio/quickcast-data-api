require 'sequel'
Sequel.connect(ENV['DATABASE_URL'])

class User < Sequel::Model
  plugin :validation_helpers
  plugin :secure_password
  def validate
    super
    validates_presence [:email]
    validates_format /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, :email
    validates_unique :email
  end

  one_to_many :apps
end