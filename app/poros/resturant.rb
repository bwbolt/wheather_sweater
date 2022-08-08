class Resturant
  attr_reader :name, :address

  def initialize(data)
    @name = data[:name]
    @address = format_address(data)
  end

  def format_address(data)
    "#{data[:location][:address1]}, #{data[:location][:city]}, #{data[:location][:state]}, #{data[:location][:zip_code]} "
  end
end
