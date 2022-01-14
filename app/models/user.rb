class User < ApplicationRecord
  has_many :dogs, dependent: :destroy
  has_many :user_accounts, dependent: :destroy
  validates :email, presence: true
end
