# frozen_string_literal: true

class ChangeColumnTypeInAccounts < ActiveRecord::Migration[5.2]
  def self.up
    change_table :accounts do |t|
      t.change :is_private, :text, default: 'public'
    end
  end

  def self.down
    change_table :accounts do |t|
      t.change :is_private, :boolean, default: false
    end
  end
end
