class CreatePreferenceOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :preference_orders do |t|
      t.timestamps
      t.references :user_session, foreign_key: true
    end
  end
end
