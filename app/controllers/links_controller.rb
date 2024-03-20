class LinksController < ApplicationController
  before_action :set_link, only: [:show]

  def index
    @links = Link.recent_first
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to root_path
    else
      @links = Link.recent_first # caso o link não seja salvo, a lista de links é renderizada novamente
      render :index, status: :unprocessable_entity
    end
  end

  def show ; end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end