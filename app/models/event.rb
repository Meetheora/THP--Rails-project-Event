class Event < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :attendances, dependent: :destroy
  has_many :participants, through: :attendances, source: :user
  has_one_attached :photo
  
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: {greater_than: 0}
  validates :title, presence: true, length: {in: 5..140}
  validates :description, presence: true, length: {in: 20..1000}
  validates :price, presence: true, numericality: {in: 0..1000}
  validates :location, presence: true
  
  validate :start_date_cannot_be_in_the_past
  validate :duration_multiple_of_five
  validate :photo_presence

  def is_free?
  price == 0
  end

  def photo_presence
    errors.add(:photo, "Veuillez uploader une photo") unless photo.attached? #errors is an ActiveModel object
  end

  private
  def start_date_cannot_be_in_the_past
    return if start_date.blank?
    if start_date < Time.current
      errors.add(:start_date, "ne peut pas être dans le passé")
    end
  end

  def duration_multiple_of_five
    errors.add(:duration, "must be multiple of 5") if duration && duration % 5 != 0
  end
end
