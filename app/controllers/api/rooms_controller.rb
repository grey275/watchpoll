class Api::RoomsController < ApplicationController
  def create
    playlist = Playlist.create(playlist_uid: params[:playlist_uid])
    room = Room.create(
      playlist: playlist,
      name: params[:name],
      runtime: params[:runtime],
    )
    room.reload
    room.run
  end

  def index
    results = Room.all.map { |u| {
      room_id: u.id,
      room_name: u.name,
      # playlist_id: u.playlist_id,
      playlist_uid: u.playlist.playlist_uid,
      current_video_uid: u.current_video
      }
    }
    #puts "rooms #{results}"
    render :json => results
  end

  def show
    room = Room.find(params[:room_id])
    render :json => {
      current_video_uid: room.current_video,
      pool_playlist_uid: room.playlist.playlist_uid,
      standings: room.video_polls.last.standings,
      users: room.current_user_sessions,
    }
  end

  def run
    Room.find(params[:room_id]).run
  end

  def cycle
    room = Room.find(params[:room_id])
    room.cycle_video
    # render :json => {chosen: room.video_polls.second_to_last.played_video.title}
  end

  def stop
  end

  private
  def get_room
  end
end
