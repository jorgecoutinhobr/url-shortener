class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = Link.recent_first
    @link ||= Link.new 
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

  def edit ; end

  def update 
    if @link.update(link_params)
      redirect_to @link
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    if @link.destroy
      redirect_to root_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end