require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/param'
#require_relative '../models/models.rb' # remove, require models in controllers that use them
require_relative '../serialisers/error_serialiser.rb'
require_relative '../helpers/versioned_routes.rb'
require_relative '../helpers/application_helpers.rb'

class ApplicationEndpoints < Sinatra::Base

  helpers Sinatra::Param
  helpers ApplicationHelpers
  register VersionedRoutes

  set :version, 'v1'
  set :raise_sinatra_param_exceptions, true

  run! if app_file == $0

  get '/' do
    protected!
    erb "Quickcast Data API #{settings.version}, running in #{settings.environment}."
  end

  not_found do
    json render_error(404, "Not found")
  end

  error 401 do
    json render_error(401, "Not authorised")
  end

  error Sinatra::Param::InvalidParameterError do
    status 400
    json render_error(400, "Invalid parameter",  env['sinatra.error'].message + ": " + env['sinatra.error'].param)
  end

end