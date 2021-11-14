class Api::V1::BackgroundsController < ApplicationController

  def index
    background = BackgroundsFacade.search_image(params[:location])
    render json: ImageSerializer.one_image(background)
  end
end
