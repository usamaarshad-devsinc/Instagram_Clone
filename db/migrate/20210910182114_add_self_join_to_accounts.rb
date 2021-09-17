# frozen_string_literal: true

class AddSelfJoinToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :followee_id, :integer
  end
end
