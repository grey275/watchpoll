class CreateVideoPolls < ActiveRecord::Migration[5.2]
  def change
    create_table :video_polls do |t|
      t.references :room, foreign_key: true
      t.time :poll_open_time
      t.string :played_video_id

      t.timestamps
    end
  end
end
