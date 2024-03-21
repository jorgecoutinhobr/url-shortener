class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :check_if_editable, only: [:edit, :update, :destroy]

  def index
    @pagy, @links = pagy(Link.recent_first, items: 10)
    @link ||= Link.new 
  end

  def create
    @link = Link.new(link_params.with_defaults(user: current_user))
    if @link.save
      respond_to do |format|
        format.html { redirect_to @link }
        format.turbo_stream { render turbo_stream: [
          turbo_stream.prepend("links", @link),
          turbo_stream.replace("link_form", partial: "links/form", locals: { link: Link.new })
        ] }
      end
    else
      index # caso o link não seja salvo, a lista de links é renderizada novamente
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

  def check_if_editable
    if @link.editable_by?(current_user)
      true
    else
      redirect_to @link, alert: "You cannot edit this link"
    end
  end
end