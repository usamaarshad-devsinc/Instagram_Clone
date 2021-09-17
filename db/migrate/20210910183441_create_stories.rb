# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.text :description
      t.belongs_to :account

      t.timestamps
    end
  end
end
