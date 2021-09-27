# frozen_string_literal: true

class DropTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :posts do end # rubocop:disable Style/BlockDelimiters
    drop_table :stories do end # rubocop:disable Style/BlockDelimiters
    drop_table :likes do end # rubocop:disable Style/BlockDelimiters
    drop_table :comments do end # rubocop:disable Style/BlockDelimiters
  end
end
