class ApplicationController < ActionController::API
  def bad_request
    render json: ErrorSerializer.bad_request, status: 400
  end

  def record_not_found
    render json: ErrorSerializer.not_found(params[:location]), status: 404
  end
end
