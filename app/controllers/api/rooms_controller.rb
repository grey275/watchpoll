class Api::RoomsController < ApplicationController
  def index
    render :json => {
      message: "hello index!"
    }
  end

  def show
    room = Room.find(params[:id])
    unless room

    end
    render :json => {
      current_video_uid: room.current_video,
      pool_playlist_uid: room.playlist.playlist_uid,
      standings: room.video_polls.last.standings,
      users: room.current_user_sessions,
    }
  end
end
