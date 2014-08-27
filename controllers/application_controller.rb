require 'sinatra/base'
require 'sinatra/json'
require_relative '../serialisers/error_serialiser.rb'
require_relative '../helpers/versioned_routes.rb'
require_relative '../helpers/application_helpers.rb'

class ApplicationController < Sinatra::Base

  helpers ApplicationHelpers
  register VersionedRoutes

  set :version, 'v1'

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

end