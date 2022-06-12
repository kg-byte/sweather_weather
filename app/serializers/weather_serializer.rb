class WeatherSerializer 
  def self.format_weather(data)

  	{
  	   data: {
           id: nil,
         type: 'forecast',
   attributes: {
          current_weather: {
               datetime: data[:current_weather].datetime,
                sunrise: data[:current_weather].sunrise,
                 sunset: data[:current_weather].sunset,
            temperature: data[:current_weather].temperature,
             feels_like: data[:current_weather].feels_like,
               humidity: data[:current_weather].humidity,
                    uvi: data[:current_weather].uvi,
             visibility: data[:current_weather].visibility,
             conditions: data[:current_weather].conditions,
                   icon: data[:current_weather].icon
                            },
            daily_weather:
              data[:daily_weather].map do |dw|
                  {
                   date: dw.date,
                sunrise: dw.sunrise,
                 sunset: dw.sunset,
               max_temp: dw.max_temp,
               min_temp: dw.min_temp,
             conditions: dw.conditions,
                   icon: dw.icon
                  }
                end,
            hourly_weather: 
              data[:hourly_weather].map do |hw|
                  {
                    time: hw.time,
             temperature: hw.temperature,
              conditions: hw.conditions,
                    icon: hw.icon
                  }
                end
  	           }
            }
    }
  end
end