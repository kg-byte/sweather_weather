class MapquestFacade

  def self.get_geocode(location)
  	MapquestService.get_geocode(location)[:results][0][:locations].first[:latLng]
  end

end