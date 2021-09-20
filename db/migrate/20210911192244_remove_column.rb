# frozen_string_literal: true

class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :followee_id
  end
end
