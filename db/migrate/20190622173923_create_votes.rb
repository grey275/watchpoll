class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :candidate_video, foreign_key: true
      t.int "vote_weight"
      t.timestamps
    end
  end
end
