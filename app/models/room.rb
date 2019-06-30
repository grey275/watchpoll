class Room < ApplicationRecord
  has_many :user_sessions
  has_many :video_polls
  has_one :candidate_video
  belongs_to :playlist

  def cycle_video
    if video_polls.count > 0
      current_video_poll.select_winner
      puts 'no polls!'
    end
    self.generate_video_poll
    RoomsChannel.broadcast_state self
  end

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
      room_id: id
    )
    unplayed_videos = get_unplayed_videos

    puts ' '
    puts 'chosen - '
    6.times.each do
      video_index = rand(unplayed_videos.length)
      video = unplayed_videos[video_index]
      unplayed_videos.delete_at(video_index)
      CandidateVideo.create(
        video: video,
        video_poll: video_poll,
      )
      puts video.title
    end
    puts ' '
    video_poll
  end

  def current_video
    if self.video_polls.count > 1
      video_id = self.video_polls.second_to_last.played_video_id
      video_id and Video.find(video_id)
    end
  end

  def current_video_poll
    video_polls.last
  end

  def current_user_sessions
    self.user_sessions.where end: nil
  end
end
