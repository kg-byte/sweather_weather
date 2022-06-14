class MapquestFacade
  class << self
    def get_geocode(location)
      MapquestService.get_geocode(location)[:results][0][:locations].first[:latLng]
    end

    def get_route(origin, destination)
      data = route_data(origin, destination)
      return Trip.new(origin, destination, data) if valid_trip(data)
      return ImpossibleRoute.new(origin, destination) unless valid_trip(data)
    end

    private

    def json_params(origin, destination)
      { locations: [origin, destination] }.to_json
    end

    def route_data(origin, destination)
      params = json_params(origin, destination)
      MapquestService.get_route(params)
    end

    def valid_trip(data)
      data[:route][:routeError][:errorCode] != 2
    end
  end
end
