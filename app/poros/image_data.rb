class ImageData
attr_reader :location, :image_url, :source, :author, :logo
  def initialize(data, location)
  	@location = location 
  	@image_url = data[:src][:original]
  	@source = data[:url]
  	@author = data[:photographer]
  	@logo = "https://images.pexels.com/lib/api/pexels.png"
  end

end