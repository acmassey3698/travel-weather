class ImageSerializer
  def self.one_image(image)
    {
      "data":{
        "type": "image",
        "id": nil,
        "attributes":{
          "image":{
            "location": image.location,
            "image_url": image.image_url,
            "credit":{
              "author": image.author,
              "profile": image.profile
            }
          }
        }
      }
    }
  end

end
