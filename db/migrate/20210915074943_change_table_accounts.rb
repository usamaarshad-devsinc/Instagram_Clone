class ChangeTableAccounts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :accounts, :is_private, from: true, to: false
    change_column_null :accounts, :username, false
    change_column_null :accounts, :full_name, false
  end
end
