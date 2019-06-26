class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.references :playlist, foreign_key: true
      t.string :video_uid
      t.timestamps
    end
  end
end
