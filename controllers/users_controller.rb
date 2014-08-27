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

end