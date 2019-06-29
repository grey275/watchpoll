class RoomsChannel < ApplicationCable::Channel
  def subscribed
    puts 'Subscribed!'
    @room = Room.find(params[:room_id])
    puts('room id ' + @room.id.to_s)
    stream_for @room
    RoomsChannel.broadcast_to(
      @room,
      {
        current_video_uid: @room.current_video,
        pool_playlist_uid: @room.playlist.playlist_uid,
        standings: @room.video_polls.last.standings,
        users: @room.current_user_sessions,
        new_poll: true,
      }
    )
  end

  def received(data)
    console.log('received!')
    # self.broadcast_to(@room, data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
