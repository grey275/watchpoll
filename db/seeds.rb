# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Preference.destroy_all
PreferenceOrder.destroy_all
CandidateVideo.destroy_all
VideoPoll.destroy_all
Video.destroy_all
UserSession.destroy_all

User.destroy_all
Room.destroy_all
Playlist.destroy_all


playlist1 = Playlist.create( playlist_uid: 'PLtMJF5iI4w_R97IGHws4XbC1i55FBXY1e')
playlist2 = Playlist.create( playlist_uid: 'PLtMJF5iI4w_RnTohhNAkQCgb0VNDXdsDV')

# # # --------------------------

room1 = Room.create!(
     name: 'Room1',
     playlist: playlist1,
     #playlist_id: 10,
     runtime: 15
)

room2 = Room.create!(
      name: 'Room2',
      playlist: playlist2,
      runtime: 15
)

# # # --------------------------


user1 = User.find_or_create_by! username: 'User1'
user2 = User.find_or_create_by! username: 'User2'


# # # --------------------------
session1 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)
session2 = UserSession.create!(user: user2, room: room2, start: 1.days.ago)
session3 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)
session4 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)

# # --------------------------
video1 = Video.create(playlist: playlist1, video_uid: 'eVTXPUF4Oz4')
video2 = Video.create(playlist: playlist1, video_uid: 'vx2u5uUu3DE')
video3 = Video.create(playlist: playlist1, video_uid: 'TR3Vdo5etCQ')
video4 = Video.create(playlist: playlist1, video_uid: '5anLPw0Efmo')
video5 = Video.create(playlist: playlist1, video_uid: 'Jne9t8sHpUc')

video1a = Video.create(playlist: playlist2, video_uid: 'fUis9yny_lI')
video2a = Video.create(playlist: playlist2, video_uid: 'yL3lJfpenAc')
video3a = Video.create(playlist: playlist2, video_uid: 'IzAO9A9GjgI')
video4a = Video.create(playlist: playlist2, video_uid: 'ILWSp0m9G2U')
video5a = Video.create(playlist: playlist2, video_uid: 'tn7kaOQvEfM')

videopoll1 = VideoPoll.create(
    room: room1,
    poll_open_time: 15,
    #played_video_id: 'eVTXPUF4Oz4'
    played_video_id: video1.id
)

videopoll2 = VideoPoll.create(
    room: room2,
    poll_open_time: 15 ,
    played_video_id: video1a.id
)

videopoll13= VideoPoll.create(
  room: room1,
  poll_open_time: 15 ,
  played_video_id: video2.id
)



CandidateVideo.create(
    video: video1,
    video_poll: videopoll1,
)

  vidselected1 = CandidateVideo.create(
    video: video2,
    video_poll: videopoll1
  )

  CandidateVideo.create(
    video: video3,
    video_poll: videopoll1
  )

  CandidateVideo.create(
    video: video4,
    video_poll: videopoll1
  )

  CandidateVideo.create(
    video: video5,
    video_poll: videopoll1
  )

#   #///


  CandidateVideo.create(
    video: video1a,
    video_poll: videopoll2
)

vidselected2 = CandidateVideo.create(
    video: video2a,
    video_poll: videopoll2
  )

  CandidateVideo.create(
    video: video3a,
    video_poll: videopoll2
  )

  CandidateVideo.create(
    video: video4a,
    video_poll: videopoll2
  )

  CandidateVideo.create(
    video: video5a,
    video_poll: videopoll2
  )

preference_order_list_1 = videopoll1.candidate_videos.map {|video| video.id}

preference_order1 = PreferenceOrder.create_with_preference_order_list(
  session1,
  videopoll1,
  preference_order_list_1,
)

preference_order2 = PreferenceOrder.create_with_preference_order_list(
  session3,
  videopoll1,
  preference_order_list_1,
)

preference_order4 = PreferenceOrder.create_with_preference_order_list(
  session4,
  videopoll1,
  preference_order_list_1,
)

preference_order4 = PreferenceOrder.create_with_preference_order_list(
  session1,
  videopoll1,
  preference_order_list_1,
)