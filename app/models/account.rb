class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_pic, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests_recieved, foreign_key: 'recipient_id', class_name: 'Request', dependent: :destroy
  has_many :requests_sent, foreign_key: 'sender_id', class_name: 'Request', dependent: :destroy

  validate :presence_check
  after_create Proc.new{ is_private = false}
  after_update :check_for_pending_requests

  private
  def presence_check
    if [full_name, username].reject(&:blank?).size < 2
      errors[:base] << ("Please give both - fullname and username.")
    end
  end

  def check_for_pending_requests
    requests_recieved.where(status:'pending').update(status: 'accepted') unless is_private
  end
end
