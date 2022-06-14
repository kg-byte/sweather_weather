class ImagesFacade
  class << self
    def get_image(location)
      ImageData.new(data(location), location)
    end

    private

    def city(location)
      location.split(',').first
    end

    def data(location)
      ImagesService.get_image(city(location))[:photos][0]
    end
  end
end
