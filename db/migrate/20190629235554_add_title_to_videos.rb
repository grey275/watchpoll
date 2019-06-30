class AddTitleToVideos < ActiveRecord::Migration[5.2]
  def up
    add_column :videos, :title, :string
  end
  def down
    remove_column :videos, :title
  end
end
