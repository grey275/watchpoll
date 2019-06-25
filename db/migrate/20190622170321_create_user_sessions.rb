class CreateUserSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_sessions do |t|
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamp :start
      t.timestamp :end

      t.timestamps
    end
  end
end
