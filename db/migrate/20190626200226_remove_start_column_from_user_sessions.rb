class RemoveStartColumnFromUserSessions < ActiveRecord::Migration[5.2]
  def up
    remove_column :user_sessions, :start
  end

  def down
    add_column :user_sessions, :start
  end
end
