class ImpossibleRoute
  attr_reader :start_city, :end_city, :travel_time

  def initialize(origin, destination)
    @start_city = origin
    @end_city = destination
    @travel_time = 'impossible route'
  end
end
