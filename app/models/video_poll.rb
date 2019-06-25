class VideoPoll < ApplicationRecord
  belongs_to :room
  has_many :candidate_videos
  has_many :preference_orders

  def standings
    all_user_preferences = self.preference_orders
    all_user_preferences
      .map do |order|
        user_preferences = order.preferences
        user_preferences
          .map do |preference|
            puts 'position: ' + preference.position.to_s
            points = user_preferences.length - (preference.position || user_preferences.length)
            puts 'points: ' + points.to_s
            {
              video_id: preference.candidate_video.id,
              video_uid: preference.candidate_video.video_uid,
              points: points
            }
          end
          .sort_by { |preference| -preference[:points]}
      end
  end
end

# ORIGINAL
# def standings
#   user_preferences = self.preference_orders
#   user_preferences
#     .map do |order|
#       order
#         .map do |preference|
#           points = order.length - preference.position + 1
#           {
#             video_id: preference.candidate_video.id,
#             video_uid: preference.candidate_video_uid,
#             points: points
#           }
#         end
#          .sort_by { |preference| -preference.points}
#     end
# end