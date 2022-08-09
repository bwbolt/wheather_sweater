class UnsplashFacade
  def self.create_image(location)
    parsed_json = UnsplashService.get_image(location)

    Image.new(parsed_json, location)
  end
end
