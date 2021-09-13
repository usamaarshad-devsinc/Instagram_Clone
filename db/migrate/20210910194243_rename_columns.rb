class RenameColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :likes, :accounts_id, :account_id
    rename_column :likes, :posts_id, :post_id

    rename_column :stories, :accounts_id, :account_id
    rename_column :comments, :accounts_id, :account_id
    rename_column :comments, :posts_id, :post_id

  end
end
