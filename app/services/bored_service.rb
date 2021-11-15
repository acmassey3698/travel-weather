class BoredService
  def self.conn
    Faraday.new('http://www.boredapi.com')
  end

  def self.activity(activity_type = "relaxation")
    conn.get('/api/activity') do |request|
      request.params['type'] = activity_type
    end
  end
end
