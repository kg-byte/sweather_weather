class OpenlibraryService 
  class << self 
  	def get_books(location)
  	  response = Faraday.get("http://openlibrary.org/search.json") do |faraday|
  	  				faraday.params['q'] = location 
  	  end
  	  JSON.parse(response.body, symbolize_names: true)
  	end
  end
end