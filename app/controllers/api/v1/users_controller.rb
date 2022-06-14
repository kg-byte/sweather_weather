class Api::V1::UsersController < ApplicationController
  include ParamsHelper
  def create
    user = User.create(downcase_email_params)
    if user.save
      api_key = user.api_keys.create! token: SecureRandom.hex
      render json: UserSerializer.format_user(user, api_key), status: :created
    else
      error = user.errors.full_messages.to_sentence.to_s
      render json: ErrorSerializer.format_error(error), status: :unauthorized
    end
  end
end
