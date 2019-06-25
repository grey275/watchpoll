class VideoPoll < ApplicationRecord
  belongs_to :room
  has_many :preference_orders
  has_many :user_sessions
  has_many :candidate_videos

  def standings
    active_user_sessions = self.room.user_sessions.where(end: nil)

    active_session_preferences = active_user_sessions
      .map do |user_session|
        user_session.preference_orders.last.preferences
      end
      .flatten

    video_points_hash = tally self.candidate_videos, active_session_preferences

    video_points_hash
      .keys
      .map do |key|
        points = video_points_hash[key]
        video_uid = CandidateVideo.find(key).video_uid
        {video_id: key, video_uid: video_uid, points: points}
      end
      .sort_by {|video_standing| -video_standing[:points]}
  end

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