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
UserSession.destroy_all

User.destroy_all
Room.destroy_all

# --------------------------

#room1 = Room.create(name: 'Room1', seed_playlist_id: 'PLtMJF5iI4w_R97IGHws4XbC1i55FBXY1e', runtime: 15)
room1 = Room.find_or_create_by! name: 'Room1', playlist_id: 'PLtMJF5iI4w_R97IGHws4XbC1i55FBXY1e', runtime: 15
room2 = Room.find_or_create_by! name: 'Room2', playlist_id: 'PLtMJF5iI4w_RnTohhNAkQCgb0VNDXdsDV', runtime: 15
# Room.create(name: 'Room2', seed_playlist_id: 1, runtime: 15)
# Room.create(name: 'Room3', seed_playlist_id: 1, runtime: 15)

# # --------------------------
user1 = User.find_or_create_by! username: 'User1'
user2 = User.find_or_create_by! username: 'User2'
# User.create!(username: 'User3')
# User.create!(username: 'User4')

# # --------------------------
session1 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)

session2 = UserSession.create!(user: user2, room: room2, start: 1.days.ago)

session3 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)
session4 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)
#room1.user_sessions.create!(user_id: 13, start: 1.days.ago)
#room1.user1.user_sessions.create!(start: 1.days.ago, end: 1.days.ago)
# UserSession.create!(room_id: 1, user_id: 1, start: 1.days.ago, end: 1.days.ago)
# UserSession.create!(room_id: 1, user_id: 2, start: 1.days.ago)
# UserSession.create!(room_id: 3, user_id: 3, start: 1.days.ago, end: 1.days.ago)
# UserSession.create!(room_id: 3, user_id: 4, start: 1.days.ago, end: 1.days.ago)

# --------------------------

videopoll1 = VideoPoll.create(
    room: room1,
    poll_open_time: 15,
    played_video_id: 'eVTXPUF4Oz4'
)


videopoll2 = VideoPoll.create(
    room: room2,
    poll_open_time: 15 ,
    played_video_id: 'fUis9yny_lI'
)

videopoll13= VideoPoll.create(
  room: room1,
  poll_open_time: 15 ,
  played_video_id: 'eVTXPUF4Oz4'
)

video = Video.create(video_uid: 'eVTXPUF4Oz4')

CandidateVideo.create(
    video: video,
    video_poll: videopoll1,
)

  vidselected1 = CandidateVideo.create(
    video_id: 'vx2u5uUu3DE',
    video_poll: videopoll1
  )

  CandidateVideo.create(
    video_id: 'TR3Vdo5etCQ',
    video_poll: videopoll1
  )

  CandidateVideo.create(
    video_id: '5anLPw0Efmo',
    video_poll: videopoll1
  )

  CandidateVideo.create(
    video_id: 'Jne9t8sHpUc',
    video_poll: videopoll1
  )

#   #///

  CandidateVideo.create(
    video_id: 'fUis9yny_lI',
    video_poll: videopoll2
)

vidselected2 = CandidateVideo.create(
    video_id: 'yL3lJfpenAc',
    video_poll: videopoll2
  )

  CandidateVideo.create(
    video_id: 'IzAO9A9GjgI',
    video_poll: videopoll2
  )

  CandidateVideo.create(
    video_id: 'ILWSp0m9G2U',
    video_poll: videopoll2
  )

  CandidateVideo.create(
    video_id: 'tn7kaOQvEfM',
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