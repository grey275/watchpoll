class ChangeCandidateVideosToReferenceVideos < ActiveRecord::Migration[5.2]
  def up
    remove_column :candidate_videos, :video_uid
    add_column :candidate_videos, :video_id, :bigint
    add_foreign_key :candidate_videos, :videos
  end
  def down
    remove_foreign_key :candidate_videos, :videos
    remove_column :candidate_videos, :video_id
    add_column :candidate_videos, :video_uid, :string
  end
end
