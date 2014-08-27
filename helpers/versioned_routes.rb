module VersionedRoutes

  def post(*args, &block)
    super *versioned_route(args), &block
  end

  def get(*args, &block)
    super *versioned_route(args), &block
  end

  def put(*args, &block)
    super *versioned_route(args), &block
  end

  def delete(*args, &block)
    super *versioned_route(args), &block
  end

  protected

  def versioned_route(args)
    args[0] = "/#{version}#{args[0]}"
    args
  end
end