# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # include ImageUploader::Attachment(:profile_pic)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_pic, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests_recieved, foreign_key: 'recipient_id',
                               class_name: 'Request',
                               dependent: :destroy,
                               inverse_of: 'recipient'
  has_many :requests_sent, foreign_key: 'sender_id',
                           class_name: 'Request',
                           dependent: :destroy,
                           inverse_of: 'sender'

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-_]+\z/ }, length: { in: 6..24 }
  validates :full_name, presence: true, format: { with: /\A[a-zA-Z ]{6,24}+\z/, message: 'only allows letters' }
  after_update :accept_pending_requests, if: :kind_changed

  # enum kind: { private: 0, public: 1 }
  private

  def accept_pending_requests
    requests_recieved.where(status: 'pending').update(status: 'accepted') unless kind.eql?('private')
  end
end
