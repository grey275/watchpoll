class PollsChannel < ApplicationCable::Channel
  def subscribed
    video_poll VideoPoll.find(params[room_id])
    stream_for video_poll
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
