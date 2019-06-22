class CreateChatEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_events do |t|
      t.references :room, foreign_key: true
      t.string :type
      t.string :data
      t.timestamp :timestamp

      t.timestamps
    end
  end
end
