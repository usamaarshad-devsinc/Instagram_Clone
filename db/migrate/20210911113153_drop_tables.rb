# frozen_string_literal: true

class DropTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :posts do end
    drop_table :stories do end
    drop_table :likes do end
    drop_table :comments do end
  end
end
