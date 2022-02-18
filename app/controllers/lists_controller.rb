require 'open-uri'

class ListsController < ApplicationController
  before_action :set_list, only: [:show]
  def index
    @lists = List.all
  end

  def show
    @bookmark = Bookmark.new
    @allmovies = Movie.all
    @listmovies = @list.movies
  end

  def new
    @list = List.new # needed to instantiate the form_for
  end

  def create
    @list = List.new(list_params)
    file = URI.open(@list.picture_url)
    @list.photo.attach(io: file, filename: "#{@list.name}_image.png", content_type: 'image/png')
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :picture_url)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
