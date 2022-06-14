class Api::V1::BooksController < ApplicationController
  include ApiKeyAuthenticatable
  include BooksEdgeCaseHelper
  include ParamsHelper
  before_action :authenticate_with_api_key!

  def index
    edge_case_response if edge_case_conditions
    book_data_with_weather unless edge_case_conditions
  end

  private

  def book_data_with_weather
    render json: BooksSerializer.format_books(current_weather, book_data, params[:location]), status: :ok
  end

  def geocode
    MapquestFacade.get_geocode(params[:location])
  end

  def book_data
    OpenlibraryFacade.get_books(params[:location], params[:quantity])
  end

  def current_weather
    OpenweatherFacade.get_weather(geocode)[:current_weather]
  end
end
