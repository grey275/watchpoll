class AddPlaylistTitle < ActiveRecord::Migration[5.2]
  def up
    add_column :playlists, :title, :string
  end
end
