class Api::V1::SessionsController < ApplicationController
  def create
    serialize_user if authenticated
    serialize_error unless authenticated
  end

  private

  def authenticated
    user && user.authenticate(params[:password])
  end

  def user
    User.find_by(email: params[:email])
  end

  def api_key
    user.api_keys.first
  end

  def error
    'Incorrect Credentials. Please try again!'
  end

  def serialize_user
    render json: UserSerializer.format_user(user, api_key), status: :ok
  end

  def serialize_error
    render json: ErrorSerializer.format_error(error), status: :unauthorized
  end
end
