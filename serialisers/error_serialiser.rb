require 'oat'
require 'oat/adapters/json_api'

class ErrorSerialiser < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "error"
    properties do |property|
      property.status(item.http_status)
      property.title(item.message)
    end
  end

end