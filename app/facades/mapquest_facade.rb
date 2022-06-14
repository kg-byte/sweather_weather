class MapquestFacade
  def self.get_geocode(location)
    MapquestService.get_geocode(location)[:results][0][:locations].first[:latLng]
  end

  def self.get_route(origin, destination)
    params = {locations: [origin, destination]}.to_json
    route_data = MapquestService.get_route(params)
    Trip.new(origin, destination, route_data)
  end
end
