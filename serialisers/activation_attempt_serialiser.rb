require 'oat'
require 'oat/adapters/json_api'

class ActivationAttemptSerialiser < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "activationAttempt"
    properties do |property|
      property.id(item.id.to_s)
      property.user_id(item.user_id.to_s)
      property.activation_code(item.activation_code)
    end
  end

end