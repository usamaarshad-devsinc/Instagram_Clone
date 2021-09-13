class DropTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :posts
    drop_table :stories
    drop_table :likes
    drop_table :comments
  end
end
