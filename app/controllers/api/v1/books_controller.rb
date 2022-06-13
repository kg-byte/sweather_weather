class Api::V1::BooksController < ApplicationController
  def index
    edge_case_response if edge_case_conditions
    if !edge_case_conditions
    	geocode = MapquestFacade.get_geocode(params[:location])
    	current_weather = OpenweatherFacade.get_weather(geocode)[:current_weather]
    	book_data = OpenlibraryFacade.get_books(params[:location], params[:quantity])
    	render json: BooksSerializer.format_books(current_weather, book_data, params[:location]), status: :ok
    end
  end


    private 
    def edge_case_response
      return render json: ErrorSerializer.format_error(error_messages[:missing_params]), status: 400 if missing_params 
      return render json: ErrorSerializer.format_error(error_messages[:empty_params]), status: 400 if empty_params 
      return render json: ErrorSerializer.format_error(error_messages[:improper_quantity]), status:400 if improper_quantity 
    end

    def edge_case_conditions
      missing_params || empty_params || improper_quantity
    end

    def missing_params
      !params.has_key?(:location) || !params.has_key?(:quantity)
    end

    def improper_quantity
      params[:quantity].to_i <= 0 
    end

    def empty_params
      params.values.include?('')
    end

    def error_messages 
      {
        missing_params: 'Both location and quantity parameters are required',
        empty_params: 'Location and quantity parameters cannot be empty',
        improper_quantity: 'Quantity parameter must be a positive integer'
      }
    end
end


