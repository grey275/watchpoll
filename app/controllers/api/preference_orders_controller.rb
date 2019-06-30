class Api::PreferenceOrdersController < ApplicationController
  def create
    @user_session = UserSession.find(params[:session_id])
    @video_poll = VideoPoll.find(params[:poll_id])
    byebug
    p_order = PreferenceOrder.create_with_preference_order_list(
      @user_session,
      @video_poll,
      params[:preference_order],
    )
  end
end
