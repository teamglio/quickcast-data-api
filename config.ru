require_relative 'endpoints/application_endpoints.rb'
require_relative 'endpoints/user_endpoints.rb'
require_relative 'endpoints/activation_attempt_endpoints.rb'

map '/' do
  use ActivationAttemptEndpoints
  use UserEndpoints
  run ApplicationEndpoints
end
