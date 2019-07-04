class CandidateVideo < ApplicationRecord
  belongs_to :video_poll
  has_many :preferences
  belongs_to :video

  def tally_preferences
    preferences.reload
    puts 'tallying ' + video.title
    preferences.select do |preference|
      active = video_poll.active_session_preferences.any? preference
      puts 'active ' + active.to_s
      if active
        # byebug
      end
      active
    end
    .sum do |preference|
      puts 'preference'
      orda_count_formula(video_poll.candidate_videos.length, preference.position)
    end
  end

  def orda_count_formula(length, position)
    length - position
  end
end
