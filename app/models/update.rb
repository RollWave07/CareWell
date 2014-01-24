class Update < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  has_many :likes

  mount_uploader :picture, ImageUploader

  acts_as_votable


end
