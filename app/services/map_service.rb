class MapService
  def self.conn
    Faraday.new('http://www.mapquestapi.com')
  end

  def self.geocode(city_state)
    conn.get('/geocoding/v1/address') do |request|
      request.params['key'] = ENV['MAPQUEST_API_KEY']
      request.params['location'] = city_state
    end
  end

  def self.get_directions(origin, destination)
    conn.get('/directions/v2/route') do |request|
      request.params['key'] = ENV['MAPQUEST_API_KEY']
      request.body = {
        "locations": [origin, destination]
        }.to_json
    end
  end
end
