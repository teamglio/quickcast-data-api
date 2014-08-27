require 'oat'
require 'oat/adapters/json_api'

class UsersSerialiser < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "users"
    collection :users, item, UserSerialiser
  end

end