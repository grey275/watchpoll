class CreateCandidateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :candidate_videos do |t|
      t.references :video_poll, foreign_key: true

      t.timestamps
    end
  end
end
