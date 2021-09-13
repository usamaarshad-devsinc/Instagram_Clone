class AddDetailsToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :full_name, :text
    add_column :accounts, :username, :text
    add_column :accounts, :is_private, :boolean
  end
end
