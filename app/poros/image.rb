class Image
  attr_reader :id, :image

  def initialize(data, location)
    @id = nil
    @image = image_data(data, location)
  end

  def image_data(data, location)
    {
      location: location,
      image_url: data[:results][0][:urls][:full],
      source: 'images.unsplash.com',
      author: data[:results][0][:user][:name],
      logo: 'https://unsplash.com/blog/content/images/max/2560/1-vQ5EsgnJkANWb5fktHPwnw.jpeg'

    }
  end
end
