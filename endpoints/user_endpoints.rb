require_relative 'application_endpoints.rb'
require_relative '../models/user.rb'
require_relative '../models/activation_request.rb'
require_relative '../serialisers/user_serialiser.rb'
require_relative '../serialisers/users_serialiser.rb'

class UserEndpoints < ApplicationEndpoints

  get '/users' do
    protected!
    users = User.all
    json UsersSerialiser.new(users).to_hash
  end

  get '/users/:user_id' do
    protected!
    param :user_id, Integer
    user = User.find(:id => params[:user_id])
    if user
      json UserSerialiser.new(user).to_hash
    else
      json UsersSerialiser.new([]).to_hash
    end
  end

  post '/users' do
    protected!
    param :name, String, required: true
    param :email, String, required: true
    param :password_confirmation, String, required: true
    param :password, String, required: true
    user = User.new(
      :name => params[:name],
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation]
      )
    if user.valid?
      user.save
      user.request_activation
      status 201
      json UserSerialiser.new(user).to_hash
    else
      error 500, json(render_error(500, "Can't create record", user.errors))
    end
  end

end