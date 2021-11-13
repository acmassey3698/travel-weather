class WeatherService
  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end

  def self.weather_data(coords)
    conn.get('/data/2.5/onecall') do |request|
      request.params['lat'] = coords[:latitude]
      request.params['lon'] = coords[:longitude]
      request.params['exclude'] = 'minutely'
      request.params['units'] = 'imperial'
      request.params['appid'] = ENV['OPEN_WEATHER_API_KEY']
    end
  end

end
