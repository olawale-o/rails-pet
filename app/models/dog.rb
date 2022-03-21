class Dog < ApplicationRecord
  belongs_to :user, foreign_key: :owner_id, class_name: 'User', counter_cache: true
  belongs_to :breed, counter_cache: true
  has_many_attached :images, dependent: :destroy

  validates_presence_of :name, :color, :weight, :description, :breed_id, :owner_id, :gender
  validates :name, uniqueness: { scope: :owner_id }
end
