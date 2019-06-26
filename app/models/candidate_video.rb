class CandidateVideo < ApplicationRecord
  belongs_to :video_poll
  has_many :preferences
  belongs_to :video
end
