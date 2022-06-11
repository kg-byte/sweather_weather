class MapQuestFacade.rb 
  def self.get_geocode(location)
  	data = MapQuestService.get_geocode(location)
  end

end