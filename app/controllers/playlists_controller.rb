class PlaylistsController < ApplicationController

  def index
    @playlist_index = Playlist.all

    if params[:query].present?
      sql_subquery = <<~SQL
        playlists.name ILIKE :query
        OR users.username ILIKE :query
      SQL
      @playlist_index = @playlist_index.joins(:user).where(sql_subquery, query: "%#{params[:query]}%")
    end

    @playlist = Playlist.new
    @playlists = Playlist.where(user_id: current_user)
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user

    if @playlist.save
      redirect_to playlist_path(@playlist), notice: 'playlist was sucessfully created :)'
    else
      redirect_to root_path, status: :unprocessable_entity, notice: 'playlist wasnt created :('
    end
  end

  def show
    @playlist_show = Playlist.find(params[:id])


    @item = Item.new

    @items = Item.where(playlist_id: @playlist_show)

    @songs = Song.all

    if params[:query].present?
      sql_subquery = <<~SQL
        songs.title ILIKE :query
        OR users.username ILIKE :query
      SQL
      @songs = @songs.joins(:user).where(sql_subquery, query: "%#{params[:query]}%")
    end

    @playlist = Playlist.new
    @playlists = Playlist.where(user_id: current_user)


  end


  private

  def playlist_params
    params.require(:playlist).permit(:name, :photo)
  end
end
