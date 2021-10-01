# frozen_string_literal: true

class RenameIsPrivateColumnOfAccounts < ActiveRecord::Migration[5.2]
  def change
    rename_column :accounts, :is_private, :kind
  end
end
