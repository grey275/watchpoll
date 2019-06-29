class VideoPoll < ApplicationRecord
  belongs_to :room
  has_many :preference_orders
  has_many :user_sessions
  has_many :candidate_videos

  def get_unused_random_video
    video = self.room.playlist.get_random_video
    unused_count =  self.candidate_videos.inject(0) do |unused_count, candidate_video|
      if candidate_video.video.id == video.id
        unused_count
      else
        unused_count + 1
      end
    end
    if unused_count == 0
      return nil
    end
    unless already_used
      return video
    end
    get_unused_random_video
  end

  def standings
    active_user_sessions = self.room.user_sessions.where(end: nil)

    active_session_preferences = active_user_sessions
      .select do |user_session|
        user_session.preference_orders.length > 0
      end
      .map do |user_session|
        user_session.preference_orders.last.preferences
      end
      .flatten

    video_points_hash = tally self.candidate_videos, active_session_preferences

    video_points_hash
      .keys
      .map do |key|
        points = video_points_hash[key]
        video_uid = CandidateVideo.find(key).video.video_uid
        {video_id: key, video_uid: video_uid, points: points}
      end
  end

  private
  def orda_count_formula(length, position)
    length - position
  end

  def tally candidate_videos, preferences
    preferences.inject({}) do |points_hash, preference|
      preference_points = orda_count_formula(candidate_videos.length, preference.position)
      id = preference.candidate_video.id
      points_hash[id] = (points_hash[id] || 0 ) + preference_points
      points_hash
    end
  end
end