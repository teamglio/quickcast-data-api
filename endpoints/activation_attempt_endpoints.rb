require 'bcrypt'
require_relative 'application_endpoints.rb'
require_relative '../models/activation_request.rb'
require_relative '../serialisers/activation_attempt_serialiser.rb'
require_relative '../serialisers/user_serialiser.rb'

class ActivationAttemptEndpoints < ApplicationEndpoints

  post '/activationAttempts' do
    protected!
    param :activation_code, String, required: true
    activation_request = ActivationRequest.find(:activation_code => params[:activation_code])
    if activation_request
      user = activation_request.user
      user.update_only({:active => true}, :active)
      json UserSerialiser.new(user).to_hash
    else
      status 400
      json render_error(400, "Invalid activation code")
    end
  end

end