class MapQuestService 
  class << self 
  	def get_geocode(location)
  	  response = Faraday.get(http://www.mapquestapi.com/geocoding/v1/address) do |faraday|
  	  				faraday.params['key'] = ENV.fetch('mapquest_api_key', nil)
  	  				faraday.params['location'] = location 
  	  end

  	end
  end
end