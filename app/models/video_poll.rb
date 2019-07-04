class VideoPoll < ApplicationRecord
  belongs_to :room
  has_many :preference_orders
  has_many :user_sessions
  has_many :candidate_videos
  alias_attribute :start_time, :created_at

  scope :by_created, -> { order(created_at: :asc) }
  scope :earliest_created, -> { by_created.first }
  scope :most_recently_created, -> { by_created.last }

  def end_time
    puts "start time #{start_time}"
    puts "runtime #{room.runtime}"
    start_time + room.runtime
  end

  def played_video
    played_video_id and Video.find played_video_id
  end

  def get_unused_random_video
    video = room.playlist.get_random_video
    unused_count =  candidate_videos.inject(0) do |unused_count, candidate_video|
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

  def select_winner
    update(played_video_id:  standings
          .sort_by { |video| -video[:points] }
          .first[:video_id]
    )
    reload
    VideoPoll.find(id).played_video
  end

  def active_session_preferences
    room.active_user_sessions
      .select do |user_session|
        # puts 'first test'
        # puts user_session.preference_orders.length > 0
        # ap user_session
        user_session.preference_orders.reload
        user_session.preference_orders.length > 0
      end
      .map do |user_session|
        user_session.reload
        puts 'last preference order' + user_session.preference_orders.last.id.to_s
        user_session.preference_orders.last.preferences
      end
      .flatten
  end

  def standings
    candidate_videos.reload
    reload
    puts "standings for poll: #{id}"
    candidate_videos.each { |cv| ap cv.video }
    candidate_videos.map do |c_video|
      points = c_video.tally_preferences
      video = c_video.video
      {video_id: video.id, candidate_video_id: c_video.id, video_uid: video.video_uid, points: points, title: video.title}
    end
  end

  private
end