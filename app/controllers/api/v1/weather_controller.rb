class Api::V1::WeatherController < ApplicationController
  include ApiKeyAuthenticatable
  include WeatherImagesEdgeCaseHelper
  include ParamsHelper

  def index
    edge_case_response if edge_case_conditions
    if !edge_case_conditions
      geocode = MapquestFacade.get_geocode(params[:location])
      weather_info = OpenweatherFacade.get_weather(geocode)
      render json: WeatherSerializer.format_weather(weather_info), status: :ok
    end
  end
end
