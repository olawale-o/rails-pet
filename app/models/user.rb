class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :dogs, class_name: 'Dog', foreign_key: :owner_id, dependent: :destroy
  has_many :user_accounts, dependent: :destroy
  validates_presence_of :username, :email
end
