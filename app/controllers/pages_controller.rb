class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @users = User.all.sample(3)
    @songs = Song.all.sample(6)

    @playlist = Playlist.new
    @playlists = Playlist.where(user_id: current_user)
  end

  def dashboard
    @user = current_user
    @songs = Song.where(user_id: @user)

    @song_new = Song.new

    @playlist = Playlist.new
    @playlists = Playlist.where(user_id: current_user)
  end
end
