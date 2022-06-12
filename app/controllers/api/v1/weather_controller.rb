class Api::V1::WeatherController < ApplicationController
  def index
  	geocode = MapquestFacade.get_geocode(params[:location])
  	weather_info = OpenweatherFacade.get_weather(geocode)
  	render json: WeatherSerializer.format_weather(weather_info), status: :ok
  end
end