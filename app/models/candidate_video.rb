class CandidateVideo < ApplicationRecord
  belongs_to :video_poll
  has_many :preferences
end
