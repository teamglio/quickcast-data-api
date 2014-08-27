require 'oat'
require 'oat/adapters/json_api'

class ErrorSerialiser < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "error"
    properties do |property|
      property.status(item[:status].to_s)
      property.title(item[:title])
      property.description(item[:description]) if item[:description]
    end
  end

end