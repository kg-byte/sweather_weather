module TripsEdgeCaseHelper
  def edge_case_response
    if missing_params_trips
      return render json: ErrorSerializer.format_error(error_messages[:missing_params]),
                    status: 400
    end
    return render json: ErrorSerializer.format_error(error_messages[:empty_params]), status: 400 if empty_params
  end

  def edge_case_conditions
    missing_params_trips || empty_params
  end

  def error_messages
    {
      missing_params: 'Both origin and destination parameters are required',
      empty_params: 'Origin and destination parameters cannot be empty'
    }
  end
end
