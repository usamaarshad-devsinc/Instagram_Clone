class Story < ApplicationRecord
  has_one_attached :image
  belongs_to :account
  validate  :presence_check
  after_create :set_expiry

  def presence_check
    # For extra fields added in Devise.
    if self.image
      errors[:base] << ("You can't create an empty story [no image].")
    end
  end
  def set_expiry
    StoryExpiresJob.set(wait: 1.day).perform_later(id)
  end
end
