class OpenweatherService
  def self.get_weather(lat, lng)
    response = Faraday.get('https://api.openweathermap.org/data/2.5/onecall') do |faraday|
      faraday.params['appid'] = ENV.fetch('openweather_api_key', nil)
      faraday.params['units'] = 'imperial'
      faraday.params['lat'] = lat
      faraday.params['lon'] = lng
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end