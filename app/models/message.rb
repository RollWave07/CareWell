class Message < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  mount_uploader :photo, ImageUploader

end
