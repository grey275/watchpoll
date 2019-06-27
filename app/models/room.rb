class Room < ApplicationRecord
  has_many :user_sessions
  has_many :video_polls
  has_one :candidate_video
  belongs_to :playlist

  def get_unplayed_videos
    played_videos  = self.video_polls
      .select {|video_poll| video_poll.played_video_id }
      .map {|video_poll| video_poll.played_video_id}
      .map {|played_video_id| Video.find(played_video_id)}

    self.playlist.videos.select do |video|
      !played_videos.include? video
    end
  end

  def generate_video_poll
    # randomly pull out 6 videos
    video_poll = VideoPoll.create(
      room: self
    )
    unplayed_videos = get_unplayed_videos

    6.times.each do
      video_index = rand(unplayed_videos.length)
      video = unplayed_videos[video_index]
      unplayed_videos.pop(video_index)
      CandidateVideo.create(
        video: video,
        video_poll: video_poll,
      )
    end
    video_poll
  end

  def current_video
    if self.video_polls.count > 1
      video_id = self.video_polls.second_to_last.played_video_id
      video_id and Video.find(video_id)
    end
  end

  def current_user_sessions
    self.user_sessions.where end: nil
  end
end
