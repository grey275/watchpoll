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
session1 = UserSession.create!(user: user1, room: room1, start: 1.days.ago, end: 0.days.ago)
session2 = UserSession.create!(user: user2, room: room2, start: 1.days.ago, end: 0.days.ago)
session3 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)
session4 = UserSession.create!(user: user1, room: room1, start: 1.days.ago)


videopoll1 = room1.generate_video_poll
ap videopoll1

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