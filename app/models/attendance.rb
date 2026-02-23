class Attendance < ApplicationRecord
  after_create :attendance_send
  belongs_to :user
  belongs_to :event

  def attendance_send
    UserMailer.attendance_email(self).deliver_now
  end
end
