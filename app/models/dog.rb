class Dog < ApplicationRecord
  belongs_to :user, foreign_key: :owner_id, class_name: 'User', counter_cache: true
  belongs_to :breed, counter_cache: true
  has_many_attached :images, dependent: :destroy

  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 200 }
  validates_presence_of :name, :color, :description, :breed_id, :owner_id
  validates :gender, inclusion: { in: %w[m f] }
  validates :name, uniqueness: { scope: :owner_id }

  before_validation :downcase_attributes

  private

  def downcase_attributes
    self.name = name.strip.downcase if name.present?
    self.color = color.strip.downcase if color.present?
    self.description = description.strip.downcase if description.present?
    self.gender = gender.strip.downcase if gender.present?
    self.weight = weight.strip.downcase if weight.present?
  end
end
