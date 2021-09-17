# frozen_string_literal: true

class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.text :description
      t.references :account, foreign_key: true

      t.timestamps
    end
    create_table :posts do |t|
      t.text :description
      t.references :account, foreign_key: true

      t.timestamps
    end
    create_table :comments do |t|
      t.text :text
      t.references :account, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end

    create_table :likes do |t|
      t.references :account, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
