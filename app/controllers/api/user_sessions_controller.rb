class Api::UserSessionsController < ApplicationController
  def create
    user = User.create()
    room = Room.find(params[:room_id])
    user_session = UserSession.create(room: room, user: user)
    session[:user_session_id] = user_session.id
  end
end
