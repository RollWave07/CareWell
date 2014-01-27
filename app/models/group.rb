class Group < ActiveRecord::Base
  has_many :users

  mount_uploader :picture, ImageUploader

end
