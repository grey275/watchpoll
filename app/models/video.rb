class Video < ApplicationRecord
  belongs_to :playlist
  has_many :candidate_videos
end
