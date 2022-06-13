class HourlyWeather
  attr_reader :time, :temperature, :conditions, :icon

  def initialize(data)
    @time = time_format(data[:dt])
    @temperature = data[:temp]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def time_format(time)
    datetime = Time.at(time).to_s
    Time.parse(datetime).strftime('%l:%M %p').lstrip
  end
end
