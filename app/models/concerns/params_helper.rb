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
    params.values.include?('')
  end
end