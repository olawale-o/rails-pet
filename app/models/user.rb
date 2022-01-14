class User < ApplicationRecord
  has_many :dogs
  has_many :user_accounts, dependent: :destroy
end
