# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :account
  belongs_to :post
  validates  :text, presence: true
end
