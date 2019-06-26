class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.string :playlist_uid
      t.timestamps
    end
  end
end
