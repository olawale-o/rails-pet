class Account < ApplicationRecord
  has_many :user_accounts, dependent: :destroy
end
