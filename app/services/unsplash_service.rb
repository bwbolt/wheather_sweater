class UnsplashService
  def self.get_image(location)
    response = connection.get('/search/photos') do |req|
      req.params['query'] = location.split(',').first
      req.params['client_id'] = ENV['UNSPLASH_KEY']
      req.params['page'] = 1
      req.params['per_page'] = 1
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'https://api.unsplash.com')
  end
end
