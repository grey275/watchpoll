class PreferenceOrder < ApplicationRecord
  has_many :preferences
  belongs_to :user_session
  belongs_to :video_poll

  def self.create_with_preference_order_list(
    user_session,
    video_poll,
    preference_order_list
  )
    p_order = self.create(user_session: user_session, video_poll: video_poll)
    preference_order_list.each_with_index do |video_id, index|
      Preference.create(
        preference_order: p_order,
        candidate_video_id: video_id,
        position: index
      )
    end
    room = user_session.room
    p_order
  end
end
