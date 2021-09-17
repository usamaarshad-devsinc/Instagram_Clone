# frozen_string_literal: true

class DatabaseConstraints < ActiveRecord::Migration[5.2]
  def change
    change_column_null :requests, :sender_id, false
    change_column_null :requests, :recipient_id, false
    change_column_null :requests, :status, false

    change_column_null :stories, :account_id, false

    change_column_null :posts, :account_id, false

    change_column_null :comments, :text, false
    change_column_null :comments, :post_id, false
    change_column_null :comments, :account_id, false

    change_column_null :likes, :account_id, false
    change_column_null :likes, :post_id, false
  end
end
