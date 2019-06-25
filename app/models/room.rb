class Room < ApplicationRecord
  has_many :user_sessions
  has_many :video_polls
end
