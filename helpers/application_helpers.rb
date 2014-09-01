module ApplicationHelpers

  def protected!
    unless authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      error 401
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
  end

  def render_error(status, title, description = nil)
    error = {
      status: status,
      title: title,
      description: description
    }
    ErrorSerialiser.new(error).to_hash
  end

end