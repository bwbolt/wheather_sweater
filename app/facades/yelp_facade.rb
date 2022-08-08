class YelpFacade
  def self.create_resturant(term, location)
    parsed_json = YelpService.get_resturants(term, location)
    if parsed_json[:error]
      parsed_json[:error][:description]
    else
      Resturant.new(parsed_json[:businesses][0])
    end
  end
end
