class VideoPoll < ApplicationRecord
  belongs_to :room
  has_many :candidate_videos
end
