class Trip 
attr_reader :start_city, :end_city, :travel_time, :destination_geocode

  def initialize(origin, destination, route_data)
	@start_city = origin
	@end_city = destination
	@travel_time = time_format(route_data[:route][:formattedTime])
	@destination_geocode = route_data[:route][:boundingBox][:ul]
  end

  def time_format(time)
  	hour_min = time.split(":")[0..-2]
  	hour_min.first + ' hours, ' + hour_min.last + ' minutes'
  end
end