class AddLastPlaylistCompletionTimeToRooms < ActiveRecord::Migration[5.2]
  def up
    add_column :rooms, :last_playlist_completion_time, :datetime
  end
  def down
    remove_column :rooms, :last_playlist_completion_time
  end
end
