class Room < ApplicationRecord
  has_many :user_sessions
  has_many :video_polls

  belongs_to :playlist

  scope :by_created, -> { order(created_at: :asc) }
  scope :earliest_created, -> { by_created.first }
  scope :most_recently_created, -> { by_created.last }

  def cycle_video
    if video_polls.length >= 1
      current_poll = Room.find(id).video_polls.last
      puts 'WINNER: ' + current_poll.select_winner.title
      current_poll.played_video.title
    else
    end
    puts "count before" + video_polls.count.to_s
    self.generate_video_poll
    puts "count after" + video_polls.count.to_s

    RoomsChannel.broadcast_state self
  end

  def print_vps
    video_polls.each do |vp|
      puts 'id: ' + vp.id.to_s
      puts "played: " + vp.played_video_id.to_s
    end
  end

  def next_video_time
    current_video_poll.end_time
  end

  def played_videos
    Room.find(id).video_polls
      .select {|video_poll| video_poll.played_video_id}
      .map do |video_poll|
        Video.find(video_poll.played_video_id)
      end
  end

  def get_unplayed_videos
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
    puts 'chosen'
    ap unplayed_videos
    [unplayed_videos.length, 6].min.times.each do
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
    last_poll = Room.find(id).video_polls.second_to_last
    if ( (last_poll) &&
      (last_poll.played_video))
      puts "USINT LAST POLL TO GET VIDEO"
      last_poll.played_video
    else
      puts "CURRENT VIDEO IS FIRST"
      playlist.videos.first
   end
  end

  def current_video_uid
    current_video.video_uid
  end

  def current_video_poll
    Room.find(id).video_polls.last
  end

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
        users: current_user_sessions,
        poll_id: (current_video_poll and current_video_poll.id),
      }
  end


  def current_user_sessions
    self.user_sessions.where end: nil
  end

  def run
    Thread.new do
      3.times do
        cycle_video
        sleep runtime
      end
    end
    puts 'running!'
  end

  def run_test
    seconds_till_next_video = (next_video_time - Time.now)
    if seconds_till_next_video >= 0
      sleep seconds_till_next_video
    end
    cycle_video
    puts 'cycling'
  end
end
