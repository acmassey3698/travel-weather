class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)

    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.user_info(user)
    else
      unauthorized
    end
  end
end
