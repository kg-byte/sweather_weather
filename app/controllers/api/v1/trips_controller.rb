class Api::V1::TripsController < ApplicationController
  include ApiTokenAuthenticatable
  include TripsEdgeCaseHelper
  include ParamsHelper
  before_action -> { authenticate_with_api_key(trip_params[:api_key]) }

  def index
    edge_case_response if edge_case_conditions
    unless edge_case_conditions
      serialize_valid_trip(trip) if trip.instance_of?(Trip)
      serialize_impossible_route(trip) if trip.instance_of?(ImpossibleRoute)
    end
  end

  private

  def trip
    MapquestFacade.get_route(trip_params[:origin], trip_params[:destination])
  end

  def eta_weather
    OpenweatherFacade.get_weather_at_eta(trip.destination_geocode, trip.eta_in_hours)
  end

  def serialize_valid_trip(trip)
    render json: TripSerializer.format_trip(trip, eta_weather), status: :ok
  end

  def serialize_impossible_route(trip)
    render json: TripSerializer.format_trip(trip), status: :ok
  end
end
