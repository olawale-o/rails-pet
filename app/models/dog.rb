class Dog < ApplicationRecord
  belongs_to :user, foreign_key: :owner_id, class_name: 'User', counter_cache: true
  belongs_to :breed, counter_cache: true
  has_many_attached :images, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :weight, presence: true,
                     numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 200,
                                     message: ->(_, data) { format('%s must be between 20 and 200', data[:value]) } }
  validates_presence_of :breed_id, :owner_id
  validates_presence_of :name, { message: 'Name cannot be blank' }
  validates_presence_of :color, { message: 'Color cannot be blank' }
  validates_presence_of :description, { message: 'Color cannot be blank' }
  validates :gender, inclusion: { in: %w[m f], message: 'Gender can either be m or f' }
  validates :name, uniqueness: { scope: :owner_id,
                                 message: ->(_, data) { format('%s has already be taken by you', data[:value]) } }

  before_validation :downcase_attributes
  before_create :set_pet_profile_pic

  def breed_name
    breed.name
  end

  def owner
    user.username
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  private

  def downcase_attributes
    self.name = name.strip.downcase if name.present?
    self.color = color.strip.downcase if color.present?
    self.description = description.strip.downcase if description.present?
    self.gender = gender.strip.downcase if gender.present?
    self.weight = weight.strip.downcase if weight.present?
  end

  def link_blob(blob)
    Rails.application.routes.url_helpers.rails_blob_path(blob, only_path: true)
  end

  def set_pet_profile_pic
    self.pic_url = link_blob(images.first.blob) if images.present?
  end
end
