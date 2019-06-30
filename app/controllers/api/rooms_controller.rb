class Api::RoomsController < ApplicationController
  def index
    results = Room.all.map { |u| {
      room_id: u.id, 
      room_name: u.name,
      playlist_id: u.playlist_id,
      playlist_uid: u.playlist.playlist_uid,
      current_video_id: u.current_video
      }
    }
    #puts "rooms #{results}"
    render :json => results
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
