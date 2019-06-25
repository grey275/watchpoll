class Api::RoomsController < ApplicationController
  def index
    render :json => {
      message: "hello index!"
    }
  end

  def show
    room = Room.find(params[:id])
    render :json => {
      pool_playlist: room.seed_playlist_id,
      standings: room.video_polls.last.standings,
      users: room.user_sessions,
    }
  end
end
