# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.belongs_to :account
      t.belongs_to :post

      t.timestamps
    end
  end
end
