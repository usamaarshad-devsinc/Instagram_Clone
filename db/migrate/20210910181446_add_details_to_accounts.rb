# frozen_string_literal: true

class AddDetailsToAccounts < ActiveRecord::Migration[5.2]
  def change
    change_table :accounts, bulk: true do |t|
      t.text :full_name
      t.text :username
      t.boolean :is_private
    end
  end
end
