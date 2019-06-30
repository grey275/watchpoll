require 'timeout'

class RoomsChannel < ApplicationCable::Channel
  def subscribed
    puts 'Subscribed!'
    @num_bcs = 0;
    @room = Room.find(params[:room_id])
    puts 'room' + @room.id.to_s
    stream_for @room
  end

  def self.broadcast_state(room)
    puts 'broadcasting'
    puts "id: #{room.id}"
    RoomsChannel.broadcast_to(
      room,
      {
        current_video_uid: room.current_video,
        pool_playlist_uid: room.playlist.playlist_uid,
        standings: room.current_video_poll.standings,
        users: room.current_user_sessions,
        poll_id: room.current_video_poll.id,
      }
    )
  end

  def receive(data)
    puts 'received!!!'
    puts ''
    puts ''
    puts ''
    puts ''
    @user_session = UserSession.find(data['session_id'])
    RoomsChannel.broadcast_state(@room)
    sleep(3)
    puts 'done'
    @room.cycle_video
    # RoomsChannel.broadcast_state(@room)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts 'unsubscribed!'
    @user_session.end = Time.now;
  end
end
