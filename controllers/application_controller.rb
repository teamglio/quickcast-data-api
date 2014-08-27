require 'sinatra/base'
require 'sinatra/json'
require_relative '../serialisers/error_serialiser.rb'
require_relative '../helpers/versioned_routes.rb'
require_relative '../helpers/api_authorisation.rb'

class ApplicationController < Sinatra::Base

  set :version, 'v1'

  helpers APIAuthorisationHelper

  register VersionedRoutes

  run! if app_file == $0

  get '/' do
    protected!
    erb "Quickcast Data API #{settings.version}, running in #{settings.environment}."
  end

  not_found do
    protected!
    json ErrorSerialiser.new(env['sinatra.error']).to_hash
  end

end