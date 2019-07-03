class CandidateVideo < ApplicationRecord
  belongs_to :video_poll
  has_many :preferences
  belongs_to :video

  def tallyPreferences
    preferences.reload
    preferences.select do |preference|
      video_poll.active_session_preferences.any? preference
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
