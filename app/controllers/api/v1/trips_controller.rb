class Api::V1::TripsController < ApplicationController
  include ApiTokenAuthenticatable
  before_action -> {authenticate_with_api_key(trip_params[:api_key])}

  def index
    trip = MapquestFacade.get_route(trip_params[:origin], trip_params[:destination])
    if trip.class == Trip
      eta_weather = OpenweatherFacade.get_weather_at_eta(trip.destination_geocode, trip.eta_in_hours)
      render json: TripSerializer.format_trip(trip, eta_weather), status: :ok
    elsif trip.class == ImpossibleRoute
      render json: TripSerializer.format_trip(trip), status: :ok
    end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
