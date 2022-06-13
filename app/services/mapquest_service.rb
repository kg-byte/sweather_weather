class MapquestService
  class << self
    def get_geocode(location)
      response = Faraday.get('http://www.mapquestapi.com/geocoding/v1/address') do |faraday|
        faraday.params['key'] = ENV.fetch('mapquest_api_key', nil)
        faraday.params['location'] = location
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_route(json)
      response = Faraday.get('http://www.mapquestapi.com/directions/v2/optimizedroute') do |faraday|
        faraday.params['key'] = ENV.fetch('mapquest_api_key', nil)
        faraday.params['json'] = json
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end