class Api::V1::BooksController < ApplicationController
  def index
  	geocode = MapquestFacade.get_geocode(params[:location])
  	current_weather = OpenweatherFacade.get_weather(geocode)[:current_weather]
  	book_data = OpenlibraryFacade.get_books(params[:location], params[:quantity])
  	render json: BooksSerializer.format_books(current_weather, book_data, params[:location]), status: :ok
  end
end