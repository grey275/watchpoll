require 'async'

class Room < ApplicationRecord
  has_many :user_sessions
  has_many :video_polls

  belongs_to :playlist

  scope :by_created, -> { order(created_at: :asc) }
  scope :earliest_created, -> { by_created.first }
  scope :most_recently_created, -> { by_created.last }

  def last_playlist_completion_time
    Room.find(id)[:last_playlist_completion_time] || created_at
  end

  # Picks the next video to be played, and broadcasts it.
  def cycle_video
    video_polls.reload
    # 'poll id: ' + current_video_poll.id.to_s
    if video_polls.length >= 1
      current_poll = Room.find(id).video_polls.last
      puts 'WINNER: ' + current_poll.select_winner.title
      current_poll.played_video.title
    end
    puts "count before" + video_polls.count.to_s
    new_poll = self.generate_video_poll
    if new_poll.candidate_videos.length == 0
      throw 'generated empty poll!'
    end
    puts "count after" + video_polls.count.to_s

    RoomsChannel.broadcast_state self
  end

  def next_video_time
    current_video_poll.end_time
  end

  # videos which have a played_video_id, and haven't been completed since last_playlist_completion_time
  def played_videos
    Room.find(id).video_polls
      .select do |video_poll|
        video_poll.played_video_id &&
        (video_poll.created_at > last_playlist_completion_time)
      end
      .map do |video_poll|
        Video.find(video_poll.played_video_id)
      end
  end

  def unplayed_videos
    Room.find(id).playlist.videos.select do |video|
      !played_videos.include? video
    end
  end

  # randomly choses unplayed videos from this room's playlist
  def generate_video_poll
    # randomly pull out 6 videos
    video_poll = VideoPoll.new(
      room_id: id
    )
    puts ' '
    puts 'chosen'
    unless unplayed_videos.length >= 6
      update(last_playlist_completion_time: Time.now)
      reload
    end
    unchosen_videos = unplayed_videos
    6.times.each do
      video_index = rand(unchosen_videos.length)
      video = unchosen_videos[video_index]
      # byebug if !video
      unchosen_videos.delete_at(video_index)
      c_video = CandidateVideo.create(
        video: video,
        video_poll: video_poll,
      )
      c_video.reload
      # if !c_video
      #   byebug
      # end
    end
    video_poll.save
    video_poll.reload
    video_poll
  end

  # played video of the last poll, else choose the first video
  def current_video
    last_poll = Room.find(id).video_polls.second_to_last
    if last_poll
      if last_poll.played_video
        last_poll.played_video
      else
        last_poll.candidate_videos.first.video
      end
    else
      playlist.videos.first
   end
  end

  def current_video_uid
    current_video.video_uid
  end

  def current_video_poll
    Room.find(id).video_polls.last
  end

  def active_user_sessions
    user_sessions.reload
    user_sessions.where(end: nil)
  end

  # everything about the room needed by the client
  def state
    {
      current_video_state: {
        start_time: (current_video_poll and current_video_poll.start_time),
        end_time: (current_video_poll and current_video_poll.end_time),
        video_uid: current_video_uid,
        title: current_video.title
      },
      pool_playlist_uid: playlist.playlist_uid,
      standings: (current_video_poll and current_video_poll.standings),
      num_of_users: current_user_sessions.length,
      poll_id: (current_video_poll and current_video_poll.id),
      room_name: self[:name],
    }
  end

  def current_user_sessions
    self.user_sessions.where end: nil
  end

  def run
    Async do ||
      while true
        puts 'cycling'
        cycle_video
        sleep runtime
      end
    end
  end
end
