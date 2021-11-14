class Api::V1::UsersController < ApplicationController
  def create
    user         = user_params
    user[:email] = user[:email].downcase
    new_user     = User.new(user)
    if new_user.save
      new_user.update(api_key: SecureRandom.hex)
      render json: UsersSerializer.user_info(new_user), status: :created
    else
      unauthorized
    end

  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
