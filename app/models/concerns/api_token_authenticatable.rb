module ApiTokenAuthenticatable
  def authenticate_with_api_key(api_key)
    unless authenticate(api_key)
      error = 'Invalid API token!'
      render json: ErrorSerializer.format_error(error), status: :unauthorized
    end
  end

  private

  def authenticate(api_key)
    ApiKey.find_by token: api_key
  end
end
