class Api::V1::UsersController < ApplicationController
  include ParamsHelper
  def create
    user = User.create(downcase_email_params)
    if user.save
      api_key = user.api_keys.create! token: SecureRandom.hex
      serialize_user(user, api_key)
    else
      error = user.errors.full_messages.to_sentence.to_s
      serialize_error(error)
    end
  end

  private

  def serialize_user(user, api_key)
    render json: UserSerializer.format_user(user, api_key), status: :created
  end

  def serialize_error(error)
    render json: ErrorSerializer.format_error(error), status: :unauthorized
  end
end
