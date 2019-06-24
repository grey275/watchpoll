class User < ApplicationRecord
  has_many :user_sessions

  def self.users_in_room(room_id)
    room = Room.find room_id
    room
      .user_sessions
      .filter do |session|
        session.end.nil?
      end
      .map do |session|
        session.user.username
      end
  end
end
