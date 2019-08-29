class CandidateVideo < ApplicationRecord
  belongs_to :video_poll
  has_many :preferences
  belongs_to :video

  ## how many points video has from the poll
  def tally_preferences
    preferences.reload
    preferences.select do |preference|
      video_poll.active_session_preferences.any? preference
    end
    .sum do |preference|
      orda_count_formula(video_poll.candidate_videos.length, preference.position)
    end
  end

  # formula used to calculate points based on ordering
  def orda_count_formula(length, position)
    length - position
  end
end
