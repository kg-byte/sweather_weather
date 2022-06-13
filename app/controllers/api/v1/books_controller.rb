class Api::V1::BooksController < ApplicationController
  include ApiKeyAuthenticatable
  include BooksEdgeCaseHelper
  include ParamsHelper
  before_action :authenticate_with_api_key!

  def index
    edge_case_response if edge_case_conditions
    unless edge_case_conditions
      geocode = MapquestFacade.get_geocode(params[:location])
      current_weather = OpenweatherFacade.get_weather(geocode)[:current_weather]
      book_data = OpenlibraryFacade.get_books(params[:location], params[:quantity])
      render json: BooksSerializer.format_books(current_weather, book_data, params[:location]), status: :ok
    end
  end
end
