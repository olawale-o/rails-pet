class Dog < ApplicationRecord
  belongs_to :user, foreign_key: :owner_id, class_name: 'User', counter_cache: true
  belongs_to :breed, counter_cache: true
  has_many_attached :images, dependent: :destroy

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

  def breed_name
    breed.name
  end

  private

  def downcase_attributes
    self.name = name.strip.downcase if name.present?
    self.color = color.strip.downcase if color.present?
    self.description = description.strip.downcase if description.present?
    self.gender = gender.strip.downcase if gender.present?
    self.weight = weight.strip.downcase if weight.present?
  end
end
