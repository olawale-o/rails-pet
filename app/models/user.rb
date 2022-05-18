class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :dogs, class_name: 'Dog', foreign_key: :owner_id, dependent: :destroy
  has_many :user_accounts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :username, presence: { message: 'Username cannot be blank' }
  validates_uniqueness_of :username, { message: 'Username has already been taken' }
  validates_presence_of :email, uniqueness: true

  before_validation :downcase_attributes

  private

  def downcase_attributes
    self.username = username.strip.downcase if username.present?
    self.email = email.strip.downcase if email.present?
    self.first_name = first_name.strip.downcase if first_name.present?
    self.last_name = last_name.strip.downcase if last_name.present?
  end
end
