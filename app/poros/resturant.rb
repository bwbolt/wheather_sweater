class Resturant
  attr_reader :name, :address

  def initialize(data)
    @name = data[:name]
    @address = data[:location][:address1]
  end
end
