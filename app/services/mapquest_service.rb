class MapquestService
  class << self
    def get_geocode(location)
      get_url("geocoding/v1/address?location=#{location}")
    end

    def get_route(json)
      get_url("directions/v2/optimizedroute?json=#{json}")
    end

    def get_url(uri)
      response = Faraday.get("http://www.mapquestapi.com/#{uri}") do |faraday|
        faraday.params['key'] = ENV.fetch('mapquest_api_key', nil)
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
