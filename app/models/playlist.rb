class Playlist < ApplicationRecord
  has_many :videos
  has_many :rooms
end
