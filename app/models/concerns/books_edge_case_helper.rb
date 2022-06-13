module BooksEdgeCaseHelper
  def edge_case_response
    return render json: ErrorSerializer.format_error(error_messages[:missing_params]), status: 400 if missing_params 
    return render json: ErrorSerializer.format_error(error_messages[:empty_params]), status: 400 if empty_params 
    return render json: ErrorSerializer.format_error(error_messages[:improper_quantity]), status:400 if improper_quantity 
  end

  def edge_case_conditions
    missing_params || empty_params || improper_quantity
  end


  def error_messages 
    {
      missing_params: 'Both location and quantity parameters are required',
      empty_params: 'Location and quantity parameters cannot be empty',
      improper_quantity: 'Quantity parameter must be a positive integer'
    }
  end

end