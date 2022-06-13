module WeatherImagesEdgeCaseHelper
  def edge_case_response
    return render json: ErrorSerializer.format_error(error_messages[:missing_params]), status: 400 if missing_params
    return render json: ErrorSerializer.format_error(error_messages[:empty_params]), status: 400 if empty_params
  end

  def edge_case_conditions
    missing_params || empty_params
  end

  def error_messages
    {
      missing_params: 'Location parameter is required',
      empty_params: 'Location parameter cannot be empty',
    }
  end
end
