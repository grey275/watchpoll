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


playlist1 = Playlist.create(playlist_uid: 'PLMC9KNkIncKtGvr2kFRuXBVmBev6cAJ2u')
playlist2 = Playlist.create(playlist_uid: 'PLtMJF5iI4w_RnTohhNAkQCgb0VNDXdsDV')
playlist3 = Playlist.create(playlist_uid: 'PL4o29bINVT4EG_y-k5jGoOu3-Am8Nvi10')
playlist4 = Playlist.create(playlist_uid: 'PLuxqHyrCHf5N9P2KT9VCDhP1i9YJgI90c')

# # # --------------------------

room1 = Room.create!(name: 'Room1', playlist: playlist1, runtime: 10)
room2 = Room.create!(name: 'Room2', playlist: playlist2, runtime: 10)
room3 = Room.create!(name: 'Room3', playlist: playlist3, runtime: 10)
room4 = Room.create!(name: 'Room4', playlist: playlist4, runtime: 10)

# # # --------------------------

user1 = User.find_or_create_by! username: 'Peter'
user2 = User.find_or_create_by! username: 'Jack'
user3 = User.find_or_create_by! username: 'Bob'

# # # --------------------------
session1 = UserSession.create!(user: user1, room: room1, start: 1.days.ago, end: 0.days.ago)
session2 = UserSession.create!(user: user2, room: room2, start: 1.days.ago, end: 0.days.ago)