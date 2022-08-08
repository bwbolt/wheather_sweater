class YelpService
  def self.get_resturants(term, location)
    response = connection.get('/v3/businesses/search') do |req|
      req.params['term'] = term
      req.params['location'] = location
      req.headers['Authorization'] = "Bearer #{ENV['YELP_KEY']}"
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'https://api.yelp.com')
  end
end
