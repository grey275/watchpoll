class Api::UserSessionsController < ApplicationController
  def create()
    puts 'creating'
    @user = User.create(username: 'bob')
    @user_session = UserSession.create(user: @user, room_id: params[:room_id])
    render :json => {session_id: @user_session.id}
  end
end