class Api::RoomsController < ApplicationController
  def index
    render :json => {
      message: "hello index!"
    }
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
    room = Room.find(params[:room_id])
    Thread.new do
      3.times do
        sleep room.runtime
        room.cycle_video
      end
    end
    render :json => {new_video: room.current_video.title}
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
