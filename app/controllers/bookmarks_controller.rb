class BookmarksController < ApplicationController
  before_action :set_list, only: %i[new create]

  def new
    @bookmark = Bookmark.new
    @movies = Movie.all
  end

  def create
    comment = bookmark_params[:comment]
    movie = Movie.find(bookmark_params[:movie])
    @bookmark = Bookmark.new(comment: comment, movie: movie)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list.id)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
