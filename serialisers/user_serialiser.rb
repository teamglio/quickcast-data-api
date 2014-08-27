require 'oat'
require 'oat/adapters/json_api'

class UserSerialiser < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "user"
    app_links = item.apps.collect { |app| app.id.to_s }
    link :apps, app_links unless app_links.empty?
    properties do |property|
      property.id(item.id.to_s)
      property.email(item.email)
    end
  end

end