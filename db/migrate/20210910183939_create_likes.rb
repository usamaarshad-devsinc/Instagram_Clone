# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to :account
      t.belongs_to :post

      t.timestamps
    end
  end
end
