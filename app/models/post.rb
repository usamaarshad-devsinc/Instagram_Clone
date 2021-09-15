class Post < ApplicationRecord
  belongs_to :account
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validate :presence_check

  def restrict_number_of_images
    if images.size > 10
      errors[:base] << ("Post can't have more than 10 images.")
    end
  end

  def presence_check
    # For extra fields added in Devise.
    if [self.images, self.description].reject(&:blank?).size == 0
      errors[:base] << ("You can't create an empty post [no description and no image].")
    else
      restrict_number_of_images
    end
  end
end
