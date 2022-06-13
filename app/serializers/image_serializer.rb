class ImageSerializer
  def self.format_image(data)
    {
      data: {
        id: nil,
        type: 'image',
        attributes: {
          image: {
            location: data.location,
            image_url: data.image_url,
            credit: {
              source: data.source,
              author: data.author,
              logo: data.logo
            }
          }
        }
      }
    }
  end
end
