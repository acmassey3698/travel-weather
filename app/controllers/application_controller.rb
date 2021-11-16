class ApplicationController < ActionController::API
  def bad_request
    render json: ErrorSerializer.bad_request, status: 400
  end

  def record_not_found
    if params[:location].present?
      render json: ErrorSerializer.not_found(params[:location]), status: 404
    else
      render json: ErrorSerializer.not_found(params[:destination]), status: 404
    end
  end

  def unauthorized
    render json: ErrorSerializer.unauthorized, status: 401
  end
end
