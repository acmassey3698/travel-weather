class Api::V1::BackgroundsController < ApplicationController

  def index
    if params[:location].present?
      background = BackgroundsFacade.search_image(params[:location])
    else
      return bad_request
    end
    if background.present?
      render json: ImageSerializer.one_image(background)
    else
      return record_not_found
    end
  end
end
