require 'sequel'
require 'bcrypt'
require_relative 'activation_request.rb'

Sequel.connect(ENV['DATABASE_URL'])

class User < Sequel::Model
  plugin :validation_helpers
  plugin :timestamps
  plugin :secure_password, include_validations: false
  def validate
    super
    validates_presence [:email, :name]
    validates_format /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, :email
    validates_unique :email
    validates_presence [:password, :password_confirmation] if validate_password?
    if password != password_confirmation
      errors.add :password, 'doesn\'t match confirmation'
    end
  end

  def validate_password?
    password || password_confirmation
  end

  def request_activation
    activation_code = SecureRandom.urlsafe_base64
    activation_request = ActivationRequest.create(user_id: id, activation_code: activation_code)
    # send activation mail
    activation_code
  end

  one_to_many :apps
  one_to_many :activation_requests
end