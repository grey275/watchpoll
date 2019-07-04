class Api::RoomsController < ApplicationController
  def create
    byebug
    playlist = Playlist.create(playlist_uid: params[:playlist_uid])
    room = Room.create(
      playlist: playlist,
      name: params[:name],
      runtime: params[:runtime]
    )
    room.reload
    Thread.new do
      room.run
    end

    render :json => {
      room_id: room.id
    }
  end

  def index
    room_data = Room.all.map do |room|
      {
        room_id: room.id,
        room_name: room.name,
        playlist_title: room.playlist.title,
        playlist_uid: room.playlist.playlist_uid,
        current_video_uid: room.current_video_uid
      }
    end
    render :json => room_data
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
    #render :json => {chosen: room.video_polls.second_to_last.played_video.title}
  end
end
