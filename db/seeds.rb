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


live_overflow = Playlist.create(playlist_uid: 'UUlcE-kVhqyiHCcjYwcpfj9w')
vulf = Playlist.create(playlist_uid: 'RDEM33jde16RFXNYjr5hwR-UWg')
casually_explained = Playlist.create(playlist_uid: 'UUr3cBLTYmIK9kY0F_OdFWFQ')
michael_reeves = Playlist.create(playlist_uid: 'UUtHaxi4GTYDpJgMSGy7AeSw')

# playlist6 = Playlist.create(playlist_uid: 'PL88D33D34A498DFE2')
# playlist7 = Playlist.create(playlist_uid: 'PL3oW2tjiIxvS-4ZDcK0mqxvhxyXaA-qgg')
# playlist8 = Playlist.create(playlist_uid: 'PLXV4Xyd2MSo7emn6KGK_U6trmi5mZPsYw')

# # # --------------------------

room1 = Room.create!(name: 'Live overflow', playlist: live_overflow, runtime: 15)
room2 = Room.create!(name: 'Vulfpeck', playlist: vulf, runtime: 15)
room3 = Room.create!(name: 'Casually explained', playlist: casually_explained, runtime: 15)
room4 = Room.create!(name: 'Michael Reeves', playlist: michael_reeves, runtime: 15)

# room5 = Room.create!(name: 'M', playlist: playlist5, runtime: 20)
# room6 = Room.create!(name: '3D Animated Shorts', playlist: playlist6, runtime: 15)
# room7 = Room.create!(name: 'Kids 1', playlist: playlist7, runtime: 20)
# room8 = Room.create!(name: '50 Songs you need', playlist: playlist8, runtime: 20)