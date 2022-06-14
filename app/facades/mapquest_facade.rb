class MapquestFacade
  def self.get_geocode(location)
    MapquestService.get_geocode(location)[:results][0][:locations].first[:latLng]
  end

  def self.get_route(origin, destination)
    params = {locations: [origin, destination]}.to_json
    route_data = MapquestService.get_route(params)
    if route_data[:route][:routeError][:errorCode] != 2
      Trip.new(origin, destination, route_data)
    else 
      ImpossibleRoute.new(origin, destination)
    end
  end
end
