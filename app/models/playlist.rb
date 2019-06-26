class Playlist < ApplicationRecord
  has_many :videos
  has_many :rooms

  def get_random_video
    self.videos.order("RANDOM()").limit(1).first;
  end
end
