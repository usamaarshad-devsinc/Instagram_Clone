class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :accounts_id, :account_id
  end
end
