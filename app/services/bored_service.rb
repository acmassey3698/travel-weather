class BoredService
  def self.conn
    Faraday.new('http://www.boredapi.com')
  end

  def self.relaxation_activity
    conn.get('/api/activity') do |request|
      request.params['type'] = "relaxation"
    end
  end

  def self.weather_dependent(activity_type)
    conn.get('/api/activity') do |request|
      request.params['type'] = activity_type
    end
  end

end
