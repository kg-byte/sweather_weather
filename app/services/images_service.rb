class ImagesService
  class << self
    def get_image(city)
      response = Faraday.get('https://api.pexels.com/v1/search') do |faraday|
        faraday.headers['Authorization'] = ENV.fetch('pexels_api_key', nil)
        faraday.params['query'] = city
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
