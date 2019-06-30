class Api::PreferenceOrdersController < ApplicationController
  def create
    @user_session = UserSession.find(params[:session_id])
    @video_poll = VideoPoll.find(params[:poll_id])
    p_order = PreferenceOrder.create_with_preference_order_list(
      @user_session,
      @video_poll,
      params[:preference_order],
    )
    @room = Room.find params[:room_id]
    RoomsChannel.broadcast_state(@room)
  end
end
