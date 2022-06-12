class ImagesFacade
  def self.get_image(location)
  	city = location.split(',').first
  	data = ImagesService.get_image(city)[:photos][0]
  	ImageData.new(data, location)
  end
end