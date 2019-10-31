# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'cgi'
require 'uri'
require 'async'

Preference.destroy_all
PreferenceOrder.destroy_all
CandidateVideo.destroy_all
VideoPoll.destroy_all
Video.destroy_all
UserSession.destroy_all

User.destroy_all
Room.destroy_all
Playlist.destroy_all


## helper to create seeding data fast
def createRoomWithUrl(name, playlist_url, runtime=15)
  Async do
    params = CGI::parse(URI::parse(playlist_url).query)
    puts ''
    puts 'creating room'
    puts 'name: ' + name
    puts 'playlist id: ' + params['list'][0]
    playlist = Playlist.create(playlist_uid: params['list'][0])
    room = Room.create!(name: name, playlist: playlist, runtime: runtime)
    puts 'created new room ' + name
  end
end

# Unsure if async actually speeds this up, but it's worth a shot I guess
Async do
  createRoomWithUrl(
    'Puzzles!',
    'https://www.youtube.com/watch?v=abO5HPo9l_c&list=PLNZrOW6Nuocr8CeCyFIq-P1l69YddtwwV'
  )

  createRoomWithUrl(
    'Space Colonization',
    'https://www.youtube.com/watch?list=PLIIOUpOge0LufQYxcfYVqcVQOFOHFynMl'
  )

  createRoomWithUrl(
    'Michael Reeves',
    'https://www.youtube.com/watch?v=mvz3LRK263E&list=PUtHaxi4GTYDpJgMSGy7AeSw'
  )

  createRoomWithUrl(
    'Vulf',
    'https://www.youtube.com/watch?v=yG96RttfZtM&list=RDEM33jde16RFXNYjr5hwR-UWg&start_radio=1'
  )

  createRoomWithUrl(
    'Casually Explained',
    'https://www.youtube.com/watch?v=xa-4IAR_9Yw&list=PUr3cBLTYmIK9kY0F_OdFWFQ'
  )

  createRoomWithUrl(
    'Live Overflow',
    'https://www.youtube.com/watch?v=UeAKTjx_eKA&list=PUlcE-kVhqyiHCcjYwcpfj9w'
  )

  createRoomWithUrl(
    'Tier Zoo',
    'https://www.youtube.com/watch?v=pLL4yPpTCBA&list=UUHsRtomD4twRf5WVHHk-cMw'
  )

  createRoomWithUrl(
    'Two Minute Papers',
    'https://www.youtube.com/watch?v=V1eYniJ0Rnk&list=PUbfYPyITQ-7l4upoX8nvctg'
  )


  createRoomWithUrl(
    'houseum',
    'https://www.youtube.com/watch?v=hyVVoLy4LSc&list=PU58C_BhzlZIJTeomuVSD2lA'
  )

  createRoomWithUrl(
    'historia_civilis',
    'https://www.youtube.com/watch?v=9XBxMk_plhA&list=UUv_vLHiWVBh_FR9vbeuiY-A'
  )

  createRoomWithUrl(
    'Corridor digital',
    'https://www.youtube.com/watch?v=VI4NZW8q6nU&list=PLVK1Q9ppZiaB1Y8MMyPus87av8zTuHzqM'
  )

  createRoomWithUrl(
    'Wendover Productions',
    'https://www.youtube.com/watch?v=GiBF6v5UAAE&list=PU9RM-iSvTu1uPJb8X5yp3EQ'
  )

  createRoomWithUrl(
    'Primer',
    'https://www.youtube.com/watch?v=YNMkADpvO4w&list=UUKzJFdi57J53Vr_BkTfN3uQ'
  )

  createRoomWithUrl(
  '3blue1brown',
  'https://www.youtube.com/watch?v=EK32jo7i5LQ&list=UUYO_jab_esuFRV4b17AJtAw'
  )

  createRoomWithUrl(
    'Veritasium',
    'https://www.youtube.com/watch?v=-PWMQR59M68&list=UUHnyfMqiRRG1u-2MsSQLbXA'
  )

end