class ChangePlayedVideoToReferenceVideosTable < ActiveRecord::Migration[5.2]
  def up
    remove_column :video_polls, :played_video_id
    add_column :video_polls, :played_video_id, :bigint
    add_foreign_key :video_polls, :videos, column: :played_video_id
  end
  def down
    change_column :video_polls, :played_video_id, :string
    remove_foreign_key :video_polls, :videos, column: :played_video_id
  end
end