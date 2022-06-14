class Api::V1::TripsController < ApplicationController
  include ApiTokenAuthenticatable
  include TripsEdgeCaseHelper
  include ParamsHelper
  before_action -> { authenticate_with_api_key(trip_params[:api_key]) }

  def index
    edge_case_response if edge_case_conditions
    serialize_trip unless edge_case_conditions
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end

  def serialize_trip
    trip = MapquestFacade.get_route(trip_params[:origin], trip_params[:destination])
    serialize_valid_trip(trip) if trip.instance_of?(Trip)
    render json: TripSerializer.format_trip(trip), status: :ok if trip.instance_of?(ImpossibleRoute)
  end

  def serialize_valid_trip(trip)
    eta_weather = OpenweatherFacade.get_weather_at_eta(trip.destination_geocode, trip.eta_in_hours)
    render json: TripSerializer.format_trip(trip, eta_weather), status: :ok
  end

end
