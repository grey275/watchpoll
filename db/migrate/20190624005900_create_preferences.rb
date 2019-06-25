class CreatePreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :preferences do |t|
      t.integer "position"
      t.references :candidate_video, foreign_key: true
      t.references :preference_order, foreign_key: true
      t.timestamps
    end
  end
end