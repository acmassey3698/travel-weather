class Image
  attr_reader :location,
              :image_url,
              :author,
              :profile

  def initialize(attrs)
    @location  = attrs[:location]
    @image_url = attrs[:image_url]
    @author    = attrs[:author]
    @profile   = attrs[:profile]
  end

end
