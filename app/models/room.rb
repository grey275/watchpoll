class Room < ApplicationRecord
  has_many :user_sessions
  has_many :video_polls
  has_one :candidate_video

  def current_video
    if self.video_polls.count > 1
      return self.video_polls.second_to_last.played_video_id
    end
  end
end
