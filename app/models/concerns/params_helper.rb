module ParamsHelper
  def missing_params_books
    !params.has_key?(:location) || !params.has_key?(:quantity)
  end

  def missing_params
    !params.has_key?(:location)
  end

  def improper_quantity
    params[:quantity].to_i <= 0
  end

  def empty_params
    params.values.include?('') || params.values.include?(nil)
  end

  def missing_params_trips
    !params.has_key?(:origin) || !params.has_key?(:destination)
  end

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
