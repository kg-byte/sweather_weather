class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      api_key = user.api_keys.first.token
      render json: UserSerializer.format_user(user, api_key), status: :ok
    else
      error = 'Incorrect Credentials. Please try again!'
      render json: ErrorSerializer.format_error(error), status: :unauthorized
    end
  end
end