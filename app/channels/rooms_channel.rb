class RoomsChannel < ApplicationCable::Channel
  def subscribed
    puts 'Subscribed!'
    @room = Room.find(params[:room_id])
    puts 'room' + @room.id.to_s
    stream_for @room
    RoomsChannel.broadcast_state(@room);
  end

  def self.broadcast_state(room)
    RoomsChannel.broadcast_to(
      room,
      {
        current_video_uid: room.current_video,
        pool_playlist_uid: room.playlist.playlist_uid,
        standings: room.video_polls.last.standings,
        users: room.current_user_sessions,
        poll_id: room.current_video_poll.id,
      }
    )
  end

  def receive(data)
    @user_session = UserSession.find(data['session_id'])
    RoomsChannel.broadcast_state @room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    @user_session.end = Time.now;
    puts 'session!'
    puts @session
  end
end
