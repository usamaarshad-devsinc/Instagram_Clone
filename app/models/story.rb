class Story < ApplicationRecord
  has_one_attached :image
  belongs_to :account
  after_create :set_expiry

  def set_expiry
    StoryExpiresJob.set(wait: 1.day).perform_later(id)
  end
end
