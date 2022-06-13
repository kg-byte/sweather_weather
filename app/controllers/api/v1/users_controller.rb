class Api::V1::UsersController < ApplicationController 
  def create
  	params = user_params
  	params[:email] = user_params[:email].downcase
  	user = User.create(params)
  	if user.save
  	  api_key = user.api_keys.create! token: SecureRandom.hex
      render json: UserSerializer.format_user(user, api_key), status: :created
  	else 
  	  error = user.errors.full_messages.to_sentence.to_s
  	  render json: ErrorSerializer.format_error(error), status: :unauthorized
    end
  end

  private
  def user_params
  	params.permit(:email, :password, :password_confirmation)
  end
end