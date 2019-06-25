class VideoPoll < ApplicationRecord
  belongs_to :room
  has_many :candidate_videos
  has_many :preference_orders

  def standings
    all_user_preferences = self.preference_orders
    video_points_hash = self.candidate_videos.inject({}) do |video_points_hash, video|
      video_points_hash[video.id] = 0
      video_points_hash
    end

    all_user_preferences
      .each do |order|
        user_preferences = order.preferences
        user_preferences
          .each do |preference|
            points = preference.position.nil? \
              ? 0
              : user_preferences.length - preference.position
            puts 'position: ' + preference.position.to_s
            puts 'points: ' + points.to_s
            video_points_hash[preference.candidate_video_id] += points
          end
      end
    video_points_hash.keys.map do |key|
      points = video_points_hash[key]
      video_uid = CandidateVideo.find(key).video_uid
      {video_id: key, video_uid: video_uid, points: points}
    end
  end
end