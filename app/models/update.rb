class Update < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  has_many :likes

  mount_uploader :picture, ImageUploader

  acts_as_votable

  scope :week_one, lambda {where(created_at:(7.day.ago..Time.now))}

end
