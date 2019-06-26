class ChangeRoomPlaylistReference < ActiveRecord::Migration[5.2]
  def up
    remove_column :rooms, :seed_playlist_id
    add_column :rooms, :playlist_id, :bigint
    add_foreign_key :rooms, :playlists
  end
  def down
    remove_foreign_key :rooms, :playlists
    remove_column :rooms, :playlist_id
    add_column :rooms, :seed_playlist_id, :string
  end
end
