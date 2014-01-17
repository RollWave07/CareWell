class Update < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  mount_uploader :picture, ImageUploader
  
  acts_as_votable
  

end
