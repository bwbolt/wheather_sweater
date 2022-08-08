class MunchieSerializer
  include JSONAPI::Serializer
  attributes :destination_city, :forecast, :resturant
end
