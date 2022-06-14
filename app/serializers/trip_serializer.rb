class TripSerializer
  def self.format_trip(trip, weather=nil)
    if trip.class == Trip
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
            start_city: trip.start_city,
              end_city: trip.end_city,
           travel_time: trip.travel_time,
        weather_at_eta: {
                    temperature: weather.temperature,
                     conditions: weather.conditions
                        }
                    }
            }
      }
     elsif trip.class == ImpossibleRoute
      {
        data: {
          id: nil,
          type: 'roadtrip',
          attributes: {
              start_city: trip.start_city,
                end_city: trip.end_city,
             travel_time: trip.travel_time,
          weather_at_eta: nil
                      }
              }
        }
      end
  end
end
