# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :account
  belongs_to :post

  scope :total_likes_on_post, ->(post_id) { where(post_id: post_id).count }
end
