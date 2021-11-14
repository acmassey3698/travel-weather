class ImageService
  def self.conn
    Faraday.new('https://api.unsplash.com')
  end

  def self.search(location)
    conn.get('/search/photos') do |request|
      request.params['client_id'] = ENV['UNSPLASH_API_KEY']
      request.params['query'] = location + 'skyline'
      request.params['per_page'] = 1
      request.params['page'] = 1
    end
  end
end
