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

playlist5 = Playlist.create(playlist_uid: 'PLd9auH4JIHvupoMgW5YfOjqtj6Lih0MKw')
playlist6 = Playlist.create(playlist_uid: 'PL88D33D34A498DFE2')
playlist7 = Playlist.create(playlist_uid: 'PL3oW2tjiIxvS-4ZDcK0mqxvhxyXaA-qgg')
playlist8 = Playlist.create(playlist_uid: 'PLXV4Xyd2MSo7emn6KGK_U6trmi5mZPsYw')

# # # --------------------------

room1 = Room.create!(name: 'More Pop Videos', playlist: playlist1, runtime: 15)
room2 = Room.create!(name: '80 Movie Music for Jack', playlist: playlist2, runtime: 15)
room3 = Room.create!(name: 'Not more pop music', playlist: playlist3, runtime: 15)
room4 = Room.create!(name: 'My favourite animated movies', playlist: playlist4, runtime: 15)

room5 = Room.create!(name: 'The Very Best Pop', playlist: playlist5, runtime: 20)
room6 = Room.create!(name: '3D Animated Shorts', playlist: playlist6, runtime: 15)
room7 = Room.create!(name: 'Kids 1', playlist: playlist7, runtime: 20)
room8 = Room.create!(name: '50 Songs you need', playlist: playlist8, runtime: 20)