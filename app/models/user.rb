class User < ApplicationRecord
  after_create :welcome_send
  has_many :attendances
  has_many :events, through: :attendances
  has_many :admin_events, foreign_key: "admin_id", class_name: "Event"
  has_one_attached :avatar
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
