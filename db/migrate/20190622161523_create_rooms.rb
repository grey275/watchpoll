class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :seed_playlist_id
      t.integer :runtime

      t.timestamps
    end
  end
end
