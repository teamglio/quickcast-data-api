require_relative '../serialisers/user_serialiser.rb'
require_relative '../serialisers/users_serialiser.rb'

class UsersController < ApplicationController

  set :version, 'v1'

  get '/users' do
    protected!
    users = User.all
    json UsersSerialiser.new(users).to_hash
  end

  get '/users/:user_id' do
    protected!
    user = User.find(params[:user_id])
    json UserSerialiser.new(user).to_hash
  end

  post '/users' do
    protected!
    user = User.new(
      :name => params[:name],
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation]
      )
    if user.valid?
      user.save
      status 201
      json UserSerialiser.new(user).to_hash
    else
      error 400, json(render_error(400, "Invalid params", user.errors))
    end
  end

end