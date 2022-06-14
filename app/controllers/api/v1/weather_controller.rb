class Api::V1::WeatherController < ApplicationController
  include ApiKeyAuthenticatable
  include WeatherImagesEdgeCaseHelper
  include ParamsHelper
  before_action :authenticate_with_api_key!

  def index
    edge_case_response if edge_case_conditions
    serialize_weather unless edge_case_conditions
  end

  private

  def geocode
    MapquestFacade.get_geocode(params[:location])
  end

  def weather_info
    OpenweatherFacade.get_weather(geocode)
  end

  def serialize_weather
    render json: WeatherSerializer.format_weather(weather_info), status: :ok
  end
end
