class Api::V1::ImagesController < ApplicationController
  include ApiKeyAuthenticatable
  include WeatherImagesEdgeCaseHelper
  include ParamsHelper
  before_action :authenticate_with_api_key!

  def index
    edge_case_response if edge_case_conditions
    serialize_image unless edge_case_conditions
  end

  private
  def image_data
    ImagesFacade.get_image(params[:location])
  end

  def serialize_image
    render json: ImageSerializer.format_image(image_data), status: :ok
  end
end
