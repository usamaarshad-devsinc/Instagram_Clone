class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :presence_check
  after_create Proc.new{ self.is_private = false}
  has_one_attached :profile_pic, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests_recieved, foreign_key: 'recipient_id', class_name: 'Request', dependent: :destroy
  has_many :requests_sent, foreign_key: 'sender_id', class_name: 'Request', dependent: :destroy

  def presence_check
    # For extra fields added in Devise.
    if [self.full_name, self.username].reject(&:blank?).size < 2
      errors[:base] << ("Please give both - fullname and username.")
    end
  end
end
