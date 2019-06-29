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


playlist1 = Playlist.create(playlist_uid: 'PLtMJF5iI4w_R97IGHws4XbC1i55FBXY1e')
playlist2 = Playlist.create(playlist_uid: 'PLtMJF5iI4w_RnTohhNAkQCgb0VNDXdsDV')
playlist3 = Playlist.create(playlist_uid: 'PL4BrNFx1j7E5qDxSPIkeXgBqX0J7WaB2a')
playlist4 = Playlist.create(playlist_uid: 'PL86F4D497FD3CACCE')
# # # --------------------------

room1 = Room.create!(name: 'Room1', playlist: playlist1, runtime: 15)
room2 = Room.create!(name: 'Room2', playlist: playlist2, runtime: 15)
room3 = Room.create!(name: 'Room3', playlist: playlist3, runtime: 15)
room4 = Room.create!(name: 'Room4', playlist: playlist4, runtime: 15)

# # # --------------------------

user1 = User.find_or_create_by! username: 'Peter'
user2 = User.find_or_create_by! username: 'Jack'
user3 = User.find_or_create_by! username: 'Bob'

# # # --------------------------
session1 = UserSession.create!(user: user1, room: room1, start: 1.days.ago, end: 0.days.ago)
session2 = UserSession.create!(user: user2, room: room2, start: 1.days.ago, end: 0.days.ago)
session3 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)
session4 = UserSession.create!(user: user2, room: room1, start: 1.days.ago)
session5 = UserSession.create!(user: user3, room: room3, start: 1.days.ago)
session6 = UserSession.create!(user: user2, room: room4, start: 1.days.ago)

videopoll1 = room1.generate_video_poll
videopoll2 = room2.generate_video_poll
videopoll3 = room3.generate_video_poll
videopoll4 = room4.generate_video_poll

preference_order_list_1 = videopoll1.candidate_videos.map {|video| video.id}
preference_order_list_2 = videopoll2.candidate_videos.map {|video| video.id}
preference_order_list_3 = videopoll3.candidate_videos.map {|video| video.id}
preference_order_list_4 = videopoll4.candidate_videos.map {|video| video.id}
preference_order_list_5 = videopoll4.candidate_videos.map {|video| video.id}

preference_order1 = PreferenceOrder.create_with_preference_order_list(
    session1,
    videopoll1,
    preference_order_list_1,
  )
  preference_order2 = PreferenceOrder.create_with_preference_order_list(
    session1,
    videopoll1,
    preference_order_list_1,
  )
  
  preference_order3 = PreferenceOrder.create_with_preference_order_list(
    session3,
    videopoll2,
    preference_order_list_1,
  )
    
  preference_order4 = PreferenceOrder.create_with_preference_order_list(
    session4,
    videopoll3,
    preference_order_list_1,
  )

  preference_order5 = PreferenceOrder.create_with_preference_order_list(
    session5,
    videopoll2,
    preference_order_list_2,
  )

  preference_order6 = PreferenceOrder.create_with_preference_order_list(
    session5,
    videopoll3,
    preference_order_list_4,
  )

  preference_order6 = PreferenceOrder.create_with_preference_order_list(
    session5,
    videopoll4,
    preference_order_list_5,
  )