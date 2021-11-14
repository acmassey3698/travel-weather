class BackgroundsFacade

  def self.search_image(location)
    response = ImageService.search(location)
    top_result = JSON.parse(response.body, symbolize_names:true)[:results][0]
    if top_result.present?
      attributes = {
        location: location,
        image_url: top_result[:urls][:regular],
        author: top_result[:user][:username],
        profile: top_result[:user][:links][:self]
      }
      Image.new(attributes)
    else
      nil
    end
  end
end
