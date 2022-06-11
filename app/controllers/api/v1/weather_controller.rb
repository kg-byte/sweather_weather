class Api::V1::WeatherController < ApplicationController
  def index
  	geocode = MapQuestFacade.get_geocode(params[:location])
  	require 'pry'; binding.pry
  end

end