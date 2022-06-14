class Api::V1::TripsController < ApplicationController
  include ApiTokenAuthenticatable
  include TripsEdgeCaseHelper
  include ParamsHelper
  before_action -> { authenticate_with_api_key(trip_params[:api_key]) }

  def index
    edge_case_response if edge_case_conditions
    unless edge_case_conditions
      trip = MapquestFacade.get_route(trip_params[:origin], trip_params[:destination])
      if trip.instance_of?(Trip)
        eta_weather = OpenweatherFacade.get_weather_at_eta(trip.destination_geocode, trip.eta_in_hours)
        render json: TripSerializer.format_trip(trip, eta_weather), status: :ok
      elsif trip.instance_of?(ImpossibleRoute)
        render json: TripSerializer.format_trip(trip), status: :ok
      end
    end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
